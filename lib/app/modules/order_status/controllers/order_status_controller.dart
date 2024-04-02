import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/data/models/order_detail_model.dart';
import 'package:happytails/app/data/provider/order_services.dart';
import 'package:happytails/app/utils/memory_management.dart';

class OrderStatusController extends GetxController {
  var count = 0.obs;
  OrderService os = OrderService();
  var isLoading = false.obs;

  RxList<OrderDetailModel> userOrders = RxList<OrderDetailModel>();

  @override
  void onInit() {
    super.onInit();
    getUserOrders();
  }

  void getUserOrders() async {
    isLoading(true);
    try {
      int userId = MemoryManagement.getUserId() ?? 0;
      List<OrderDetailModel> fetchedOrders =
          await os.getOrdersToReceiveByUserId(userId);
      if (fetchedOrders.isNotEmpty) {
        userOrders.assignAll(fetchedOrders);
      } else {
        userOrders.clear();
        Get.snackbar(
          'Info',
          'No orders found',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch orders: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
      update();
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
