import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/data/models/order_detail_model.dart';
import 'package:happytails/app/data/provider/order_services.dart';
import 'package:happytails/app/utils/memory_management.dart';

class SellerOrdersController extends GetxController {
  final count = 0.obs;
  OrderService os = OrderService();

  RxList<OrderDetailModel> orders = RxList<OrderDetailModel>();
  @override
  void onInit() {
    super.onInit();
    getSoldProductsForUser();
  }

  void getSoldProductsForUser() async {
    try {
      int userId = MemoryManagement.getUserId() ?? 0;
      List<OrderDetailModel> fetchedProducts =
          await os.getOrdersToDeliverByUserId(userId);

      if (fetchedProducts.isNotEmpty) {
        orders.assignAll(fetchedProducts);
        debugPrint(fetchedProducts.length.toString());
        for (OrderDetailModel o in orders) {
          debugPrint(o.productName);
        }
        update();
      } else {
        Get.snackbar(
          'Info',
          'No orders found',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
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
