import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/modules/user_cart/controllers/user_cart_controller.dart';
import 'package:happytails/app/utils/asset_files.dart';
import 'package:happytails/app/utils/constants.dart';

import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var product = Get.arguments as Product;
    var userCartController = Get.find<UserCartController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName ?? ''),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: 'product+${product.productId}',
                    child: product.productImage == null
                        ? Image.asset(AssetFile.cartProductImage)
                        : Image.network(
                            getImage(
                              product.productImage,
                            ),
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName?.toUpperCase() ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        product.productDescription ?? '',
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Rs ${product.productPrice}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Product Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Seller',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            product.sellerName.toString(),
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Type',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            product.productcategoryName.toString(),
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'For',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            product.petcategoryName.toString(),
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            product.productstockQuantity.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green.shade700,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'left in stock',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            product.productstockQuantity! <= 0
                ? Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.redAccent,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "This product is currently out of stock",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      const Text(
                        "Select Quantity",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (controller.productQuantity > 1) {
                                controller.productQuantity--;
                              }
                            },
                            icon: const Icon(
                              Icons.remove,
                              size: 20,
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.productQuantity.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (product.productstockQuantity! <=
                                  controller.productQuantity.value) {
                                CustomSnackbar.errorSnackbar(
                                  context: Get.context,
                                  title: 'Limited quantity in stock',
                                  message:
                                      'The desired quantity cannot be selected due to limited quantity in stock',
                                );
                                return;
                              }
                              controller.productQuantity++;
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            CustomButton(
              width: Get.width,
              isDisabled: product.productstockQuantity! <= 0,
              label: 'Add to Cart',
              onPressed: () {
                userCartController.addToCart(
                  product: product,
                  productQuantity: controller.productQuantity.value,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
