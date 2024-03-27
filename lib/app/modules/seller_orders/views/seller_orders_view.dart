import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/utils/constants.dart';

import '../controllers/seller_orders_controller.dart';

class SellerOrdersView extends GetView<SellerOrdersController> {
  const SellerOrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Deliveries'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'SellerOrdersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
