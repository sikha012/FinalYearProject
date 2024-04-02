import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/components/user_order_card.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/views/views/delivery_timeline_view.dart';
import '../controllers/order_status_controller.dart';

class OrderStatusView extends GetView<OrderStatusController> {
  const OrderStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrderStatusController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GetBuilder<OrderStatusController>(
        builder: (controller) {
          if (controller.isLoading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.userOrders.isEmpty) {
            return const Center(
              child: Text(
                'No orders found',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.userOrders.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => DeliveryTimeline(
                      orderId: controller.userOrders[index].orderId ?? 0,
                    ),
                  );
                },
                child: UserOrderCard(orderDetail: controller.userOrders[index]),
              );
            },
          );
        },
      ),
    );
  }
}
