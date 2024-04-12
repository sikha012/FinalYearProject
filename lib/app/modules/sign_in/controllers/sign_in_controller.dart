import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_progress_indicator.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/data/provider/auth_services.dart';
import 'package:happytails/app/routes/app_pages.dart';
import 'package:happytails/app/utils/memory_management.dart';

class SignInController extends GetxController {
  final count = 0.obs;
  // Repository repository = Repository(ApiProvider());
  AuthService auth = AuthService();
  var isLoading = false.obs;
  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  dynamic token = '';

  @override
  void onInit() async {
    super.onInit();
    checkUserToken();
    token = await FirebaseMessaging.instance.getToken();
  }

  void checkUserToken() async {
    isLoading.value = true;
    var accessToken = MemoryManagement.getAccessToken();
    var refreshToken = MemoryManagement.getRefreshToken();
    var userType = MemoryManagement.getUserType();
    debugPrint("check type: $userType");
    Future.delayed(const Duration(seconds: 1), () {
      if (accessToken != null && refreshToken != null) {
        debugPrint('access token: $accessToken');
        debugPrint(refreshToken);
        if (userType == 'seller') {
          Get.offAllNamed(Routes.SELLER_MAIN);
        } else {
          Get.offAllNamed(Routes.MAIN);
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // CustomSnackbar.infoSnackbar(
        //   context: Get.context,
        //   title: 'Info',
        //   message: 'Login expired. Please sign in again',
        // );
      }
    });
  }

  void onSignIn() async {
    if (signInKey.currentState!.validate()) {
      try {
        FullScreenDialogLoader.showDialog();

        Map<String, dynamic> data = {
          "email": emailController.text,
          "password": passwordController.text,
          'token': token,
        };
        await auth.signIn(data).then((value) {
          FullScreenDialogLoader.cancelDialog();
          debugPrint('access token: ${value.accessToken}');
          debugPrint(value.refreshToken);
          MemoryManagement.setAccessToken(value.accessToken ?? '');
          MemoryManagement.setRefreshToken(value.refreshToken ?? '');
          MemoryManagement.setUserId(value.user?.userId ?? 0);
          MemoryManagement.setUserType(value.user?.userType ?? '');
          if (value.user?.userType == 'seller') {
            Get.offAllNamed(Routes.SELLER_MAIN);
          } else {
            Get.offAllNamed(Routes.MAIN);
          }
        }).onError((error, stackTrace) {
          FullScreenDialogLoader.cancelDialog();

          CustomSnackbar.errorSnackbar(
            context: Get.context,
            title: 'Invalid Credentials',
            message: error.toString(),
          );
        });
      } catch (e) {
        FullScreenDialogLoader.cancelDialog();
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong",
        );
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
