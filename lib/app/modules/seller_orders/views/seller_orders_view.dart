import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/data/models/order_detail_model.dart';
import 'package:happytails/app/utils/asset_files.dart';
import 'package:happytails/app/utils/constants.dart';

import '../controllers/seller_orders_controller.dart';

class SellerOrdersView extends GetView<SellerOrdersController> {
  const SellerOrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SellerOrdersController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Deliveries'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: GetBuilder<SellerOrdersController>(
        builder: (controller) => Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          color: Constants.backgroundColor,
          child: controller.orders.isEmpty
              ? const Center(
                  child: Text("No orders to deliver..."),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: controller.orders.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    OrderDetailModel order = controller.orders[index];
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          height: 150,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: order.productImage == null
                                    ? Image.asset(
                                        AssetFile.cartProductImage,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                      )
                                    : Image.network(
                                        getImage(
                                          order.productImage,
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        order.productName ?? '',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Ordered By: ${order.userName}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "Delivery Location: ${order.userLocation}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "Contact: ${order.userContact}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
