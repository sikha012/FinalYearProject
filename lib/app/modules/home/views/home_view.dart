import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/product_card.dart';
import 'package:happytails/app/modules/user_cart/controllers/user_cart_controller.dart';
import 'package:happytails/app/routes/app_pages.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/views/views/notifications_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(UserCartController());
    var controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.USER_CART);
              },
              child: Stack(
                children: [
                  const Icon(
                    CupertinoIcons.cart_fill,
                    size: 35,
                    color: Colors.white,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                        color: Constants.tertiaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Obx(
                        () => Center(
                          child: Text(
                            cartController.cartProducts.length.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                controller.resetNotificationCount();

                Get.to(() => const NotificationsView());
              },
              child: Stack(
                children: [
                  const Icon(
                    CupertinoIcons.bell_fill,
                    size: 35,
                    color: Colors.white,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                        color: Constants.tertiaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Obx(
                        () => Center(
                          child: Text(
                            controller.notificationCount.value.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => GridView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.PRODUCT_DETAIL,
                  arguments: controller.products[index],
                );
              },
              child: SizedBox(
                width: 200,
                child: ProductCard(
                  product: controller.products[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
