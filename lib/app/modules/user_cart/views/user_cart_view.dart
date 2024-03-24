import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/cart_product_card.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
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
        builder: (controller) => Stack(
          children: [
            Container(
              color: Constants.backgroundColor,
              margin: EdgeInsets.only(top: 20),
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
                                    value:
                                        controller.cartProducts[index].selected,
                                  ),
                                ),
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
                                : controller.makeOrder();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 17,
              top: -5,
              child: Row(
                children: [
                  const Text(
                    "Select all",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                    ),
                  ),
                  Checkbox(
                    onChanged: (value) {
                      controller.selectAllCartProducts(value ?? false);
                    },
                    value: controller.cartProducts.length ==
                            controller.selectedCartProducts.length &&
                        controller.cartProducts.isNotEmpty,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
