import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/modules/seller_orders/controllers/seller_orders_controller.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/views/views/product_orders_view.dart';

class SellerOrdersSummaryView extends GetView<SellerOrdersController> {
  const SellerOrdersSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SellerOrdersController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Orders Summary'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: GetBuilder<SellerOrdersController>(builder: (controller) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: controller.sellerProducts.length,
          itemBuilder: (context, index) {
            final product = controller.sellerProducts[index];
            int orderCount = controller.orders
                .where((order) => order.productId == product.productId)
                .toList()
                .length;

            return GestureDetector(
              onTap: () {
                Get.to(() => const ProductOrdersView(), arguments: {
                  'productId': product.productId,
                  'name': product.productName,
                });
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4)),
                        child: Image.network(
                          getImage(product.productImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(product.productName ?? 'No Name'),
                      subtitle: Text('Total Orders: $orderCount'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
