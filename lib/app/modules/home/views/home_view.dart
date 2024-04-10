import 'dart:ffi';

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
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Call method to show search TextField
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(controller),
              );
            },
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.petCategories.length,
                    itemBuilder: (context, index) {
                      var category = controller.petCategories[index];
                      bool isSelected = controller.selectedCategoryId.value ==
                          category.petcategoryId;

                      return GestureDetector(
                        onTap: () {
                          controller
                              .selectCategory(category.petcategoryId ?? 0);
                          print(
                              "Category ID: ${category.petcategoryId}, Selected ID: ${controller.selectedCategoryId.value}");
                          controller.update();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Constants.primaryColor.withOpacity(0.5)
                                : Constants.primaryColor,
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: Center(
                            child: Text(
                              controller.petCategories[index].petcategoryName ??
                                  '',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => controller.products.isEmpty
                      ? SizedBox(
                          width: Get.width,
                          height: Get.height * 0.7,
                          child: const Center(
                            child: Text(
                              "No Products matched your search...",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  final HomeController controller;

  ProductSearchDelegate(this.controller);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Constants.primaryColor,
      primaryIconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(titleLarge: TextStyle(color: Colors.black)),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear search query
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search bar
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // You can show search results here if you want to show results in a separate page or layout
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.searchProduct(query);

    return Obx(() {
      if (controller.isLoading.isTrue) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        itemCount: controller.searchResults.length,
        itemBuilder: (context, index) {
          final product = controller.searchResults[index];
          return ListTile(
            title: Text(product.productName.toString()),
            leading: Image.network(getImage(product.productImage),
                width: 50, height: 50),
            onTap: () {
              // Handle product tap, for example:
              Get.toNamed(Routes.PRODUCT_DETAIL, arguments: product);
            },
          );
        },
      );
    });
  }
}
