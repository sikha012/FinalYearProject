import 'package:get/get.dart';

import '../controllers/seller_orders_controller.dart';

class SellerOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerOrdersController>(
      () => SellerOrdersController(),
    );
  }
}
