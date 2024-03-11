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

  @override
  void onInit() {
    super.onInit();
    checkUserToken();
  }

  void checkUserToken() async {
    isLoading.value = true;
    var accessToken = MemoryManagement.getAccessToken();
    var refreshToken = MemoryManagement.getRefreshToken();
    Future.delayed(const Duration(seconds: 1), () {
      if (accessToken != null && refreshToken != null) {
        Get.offAllNamed(Routes.MAIN);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        CustomSnackbar.infoSnackbar(
          context: Get.context,
          title: 'Info',
          message: 'Login expired. Please sign in again',
        );
      }
    });
  }

  void onSignIn() async {
    try {
      FullScreenDialogLoader.showDialog();

      Map<String, dynamic> data = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      await auth.signIn(data).then((value) {
        FullScreenDialogLoader.cancelDialog();
        debugPrint(value.accessToken);
        debugPrint(value.refreshToken);
        MemoryManagement.setAccessToken(value.accessToken ?? '');
        MemoryManagement.setRefreshToken(value.refreshToken ?? '');
        Get.offAllNamed(Routes.MAIN);
      }).onError((error, stackTrace) {
        FullScreenDialogLoader.cancelDialog();

        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: "Error",
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
