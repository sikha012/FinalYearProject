import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/data/models/order_detail_model.dart';
import 'package:happytails/app/data/provider/order_services.dart';
import 'package:happytails/app/data/provider/seller_services.dart';
import 'package:happytails/app/utils/memory_management.dart';

class SellerOrdersController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  OrderService os = OrderService();
  SellerServices sellerServices = SellerServices();

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

  void updateOrderDeliveryStatus({
    required int orderDetailId,
    required String status,
    required String userFCM,
    required String productName,
  }) async {
    try {
      await sellerServices
          .updateOrderDeliveryStatus(
        orderDetailId: orderDetailId,
        status: status,
        userFCM: userFCM,
        productName: productName,
      )
          .then((value) {
        Get.snackbar(
          "Success",
          value,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        getSoldProductsForUser();
        update();
      }).onError((error, stackTrace) {
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 500),
          colorText: Colors.white,
        );
        isLoading.value = false;
        update();
      });
    } catch (exp) {
      Get.snackbar(
        "Error in code",
        exp.toString(),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 500),
        colorText: Colors.white,
      );
      isLoading.value = false;
      update();
    }
  }

  void onOrderTap(OrderDetailModel order) async {
    if (order.status != 'Shipped') {
      isLoading.value = true;
      updateOrderDeliveryStatus(
        orderDetailId: order.orderdetailId ?? 0,
        status: 'Shipped',
        userFCM: order.token ?? '',
        productName: order.productName ?? '',
      );
      // Update the order's status locally
      order.status = 'Shipped';
      isLoading.value = false;
      update(); // Refresh the UI
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
}
