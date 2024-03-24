import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/components/order_detail_card.dart';
import 'package:happytails/app/data/models/cart_product.dart';
import 'package:happytails/app/data/models/order.dart';
import 'package:happytails/app/modules/user_cart/controllers/user_cart_controller.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class OrderDetailView extends GetView {
  const OrderDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<UserCartController>();
    var selectedCartProducts =
        Get.arguments['selectedProducts'] as List<CartProduct>;
    var orderMade = Get.arguments['orderMade'] as Order;

    int getTotalProducts() {
      int count = 0;
      for (CartProduct product in selectedCartProducts) {
        count += product.productQuantity;
      }
      return count;
    }

    int itemCount = getTotalProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Constants.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.green,
                  strokeAlign: BorderSide.strokeAlignInside,
                  style: BorderStyle.solid,
                  width: 3,
                ),
              ),
              child: SizedBox(
                height: 700,
                child: selectedCartProducts.isEmpty
                    ? const Center(
                        child: Text(
                          'No products selected...',
                          style: TextStyle(
                            fontSize: 22,
                            color: Constants.primaryColor,
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: selectedCartProducts.length,
                        itemBuilder: (context, index) {
                          return OrderDetailCard(
                              cartProduct: selectedCartProducts[index]);
                        },
                      ),
              ),
            ),
            Positioned(
              bottom: 75,
              left: 21.5,
              child: Container(
                width: 350,
                height: 250,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.green,
                    strokeAlign: BorderSide.strokeAlignInside,
                    style: BorderStyle.solid,
                    width: 3,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Item Count",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "$itemCount",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Grand Total",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rs ${orderMade.order?.totalAmount ?? 0}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () async {
                        KhaltiScope.of(Get.context!).pay(
                          preferences: [
                            PaymentPreference.khalti,
                            PaymentPreference.connectIPS,
                          ],
                          config: PaymentConfig(
                            amount: orderMade.order?.totalAmount ?? 1000,
                            productIdentity: orderMade.orderId.toString(),
                            productName: "User Order",
                          ),
                          onSuccess: (PaymentSuccessModel v) {
                            cartController.createPayment(
                              grandTotal: orderMade.order?.totalAmount,
                              token: v.token,
                            );
                          },
                          onFailure: (v) {
                            Get.showSnackbar(
                              const GetSnackBar(
                                backgroundColor: Colors.red,
                                message: 'Payment failed!',
                                duration: Duration(seconds: 3),
                              ),
                            );
                          },
                          onCancel: () {
                            CustomSnackbar.errorSnackbar(
                              context: Get.context,
                              title: "Canceled",
                              message: "The order was canceled",
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.green,
                            strokeAlign: BorderSide.strokeAlignInside,
                            style: BorderStyle.solid,
                            width: 3,
                          ),
                        ),
                        child:
                            // Center(
                            //   child: Text(
                            //     "Proceed to Payment",
                            //     style: TextStyle(
                            //       fontSize: 15,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                            Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                'https://web.khalti.com/static/img/logo1.png',
                                height: 40),
                            const Text(
                              'Pay with Khalti',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
