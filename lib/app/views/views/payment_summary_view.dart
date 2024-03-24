import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/data/models/cart_product.dart';
import 'package:happytails/app/routes/app_pages.dart';
import 'package:happytails/app/utils/constants.dart';

class PaymentSummaryView extends GetView {
  const PaymentSummaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var paymentToken = Get.arguments['token'] ?? 0;
    var orderedItems = Get.arguments['orderedProducts'] as List<CartProduct>;
    debugPrint(paymentToken);
    debugPrint(orderedItems[0].product.productName);
    double getGrandTotal() {
      double grandTotal = 0.00;
      for (CartProduct item in orderedItems) {
        grandTotal += (item.product.productPrice! * item.productQuantity);
      }
      return grandTotal;
    }

    double grandTotal = getGrandTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Summary'),
        centerTitle: true,
        backgroundColor: Constants.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Get.offNamed(Routes.MAIN);
          },
          child: Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Constants.backgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.width * 0.4,
              height: Get.width * 0.4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue.shade100,
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue.shade200,
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue.shade300,
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue.shade400,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Payment Successful",
              style: TextStyle(
                fontSize: 22,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your payment token: $paymentToken",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 350,
              height: 300,
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Payment Summary",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orderedItems.length,
                      itemBuilder: (context, index) {
                        var orderedItem = orderedItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                orderedItem.product.productName ?? '',
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "${(orderedItem.product.productPrice ?? 0) * orderedItem.productQuantity}",
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Grand Total",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          grandTotal.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              label: "Continue",
              onPressed: () {
                Get.offNamed(Routes.MAIN);
              },
            ),
          ],
        ),
      ),
    );
  }
}
