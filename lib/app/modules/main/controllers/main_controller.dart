import 'package:get/get.dart';
import 'package:initial_app/app/modules/categories/views/categories_view.dart';
import 'package:initial_app/app/modules/home/views/home_view.dart';
import 'package:initial_app/app/modules/offers/views/offers_view.dart';
import 'package:initial_app/app/modules/profile/views/profile_view.dart';

class MainController extends GetxController {
  final count = 0.obs;
  var currentPageIndex = 0.obs;

  final pages = const [
    HomeView(),
    OffersView(),
    CategoriesView(),
    ProfileView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void onPageSelected(int index) {
    currentPageIndex.value = index;
    update();
  }

  void increment() => count.value++;
}
