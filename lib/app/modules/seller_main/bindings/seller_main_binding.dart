import 'package:get/get.dart';

import '../controllers/seller_main_controller.dart';

class SellerMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerMainController>(
      () => SellerMainController(),
    );
  }
}
