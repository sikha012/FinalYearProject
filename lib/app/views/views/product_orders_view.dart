import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/modules/seller_orders/controllers/seller_orders_controller.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:intl/intl.dart'; // For date formatting

class ProductOrdersView extends GetView<SellerOrdersController> {
  const ProductOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = Get.arguments['productId'] as int?;
    final productName = Get.arguments['name'] as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders for $productName'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: GetBuilder<SellerOrdersController>(builder: (controller) {
        final productOrders = controller.orders
            .where((order) => order.productId == productId)
            .toList();

        final totalRevenue = productOrders.fold<int>(
          0,
          (previousValue, order) => previousValue + (order.lineTotal ?? 0),
        );

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Orders: ${productOrders.length}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Total Revenue: $totalRevenue',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Buyer')),
                DataColumn(label: Text('Order Date')),
                DataColumn(label: Text('Quantity')),
              ],
              rows: productOrders.map((order) {
                return DataRow(cells: [
                  DataCell(Text(order.orderId.toString())),
                  DataCell(Text(order.userName ?? 'N/A')),
                  DataCell(Text(order.orderDate != null
                      ? DateFormat('yyyy-MM-dd').format(order.orderDate!)
                      : 'N/A')),
                  DataCell(Text(order.quantity.toString())),
                ]);
              }).toList(),
            ),
          ],
        );
      }),
    );
  }
}
