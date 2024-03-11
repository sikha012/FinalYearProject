import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/cart_product_card.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/routes/app_pages.dart';
import 'package:happytails/app/utils/constants.dart';

import '../controllers/user_cart_controller.dart';

class UserCartView extends GetView<UserCartController> {
  const UserCartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items in cart'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: GetBuilder<UserCartController>(
        builder: (controller) => Container(
          color: Constants.backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 500,
                child: controller.cartProducts.isEmpty
                    ? const Center(
                        child: Text(
                          'No products in the cart...',
                          style: TextStyle(
                            fontSize: 22,
                            color: Constants.primaryColor,
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.cartProducts.length,
                        itemBuilder: (context, index) => Stack(
                          children: [
                            CartProductCard(
                              cartProduct: controller.cartProducts[index],
                              index: index,
                            ),
                            Positioned(
                              right: 0,
                              child: Checkbox(
                                onChanged: (value) {
                                  controller.updateSelectedProduct(
                                    index,
                                    value ?? false,
                                  );
                                },
                                value: controller.cartProducts[index].selected,
                              ),
                            )
                          ],
                        ),
                      ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Your total:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Constants.primaryColor,
                          ),
                        ),
                        Obx(
                          () => Text(
                            'Rs. ${controller.total.value}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () async {
                        //     if (controller.cartProducts.isEmpty) {
                        //       Get.showSnackbar(const GetSnackBar(
                        //         backgroundColor: Colors.red,
                        //         message: 'Cart is empty!',
                        //         duration: Duration(seconds: 3),
                        //       ));
                        //       return;
                        //     }
                        //     var orderId = await controller.makeOrder();
                        //     if (orderId == null) {
                        //       return;
                        //     }
                        //     KhaltiScope.of(Get.context!).pay(
                        //       preferences: [
                        //         PaymentPreference.khalti,
                        //         PaymentPreference.connectIPS
                        //       ],
                        //       config: PaymentConfig(
                        //         amount: 1000,
                        //         productIdentity: orderId.toString(),
                        //         productName: "My Product",
                        //       ),
                        //       onSuccess: (PaymentSuccessModel v) {
                        //         controller.makePayment(
                        //             total: (v.amount / 100).toString(),
                        //             orderId: orderId.toString(),
                        //             otherData: v.toString());
                        //       },
                        //       onFailure: (v) {
                        //         Get.showSnackbar(const GetSnackBar(
                        //           backgroundColor: Colors.red,
                        //           message: 'Payment failed!',
                        //           duration: Duration(seconds: 3),
                        //         ));
                        //       },
                        //       onCancel: () {
                        //         Get.showSnackbar(const GetSnackBar(
                        //           backgroundColor: Colors.red,
                        //           message: 'Payment cancelled!',
                        //           duration: Duration(seconds: 3),
                        //         ));
                        //       },
                        //     );
                        //   },
                        //   child: Container(
                        //       padding: const EdgeInsets.all(10),
                        //       margin: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(10),
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 5,
                        //               blurRadius: 7,
                        //             ),
                        //           ]),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Image.network(
                        //               'https://web.khalti.com/static/img/logo1.png',
                        //               height: 40),
                        //           Text('Pay with Khalti'),
                        //         ],
                        //       )),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      width: 100,
                      color: Colors.green,
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      label: 'Continue',
                      onPressed: () {
                        controller.selectedCartProducts.isEmpty
                            ? CustomSnackbar.infoSnackbar(
                                context: context,
                                title: 'Info',
                                message: 'Select a product to continue',
                              )
                            : Get.toNamed(Routes.MAIN);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
