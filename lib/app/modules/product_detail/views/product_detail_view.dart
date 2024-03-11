import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/modules/user_cart/controllers/user_cart_controller.dart';
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
        color: Constants.backgroundColor,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'product+${product.productId}',
                  child: Image.network(
                    width: double.infinity,
                    height: Get.height * 0.4,
                    getImage(product.productImage ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName?.toUpperCase() ?? '',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        product.productDescription ?? '',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Rs ${product.productPrice}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Seller: ${product.sellerName}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Type: ${product.productcategoryName}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'For: ${product.petcategoryName}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                  icon: Icon(
                    Icons.remove,
                    size: 20,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.productQuantity.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.productQuantity++;
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 20,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: Get.width * 0.4,
                  label: 'Add to Cart',
                  onPressed: () {
                    userCartController.addToCart(
                      product: product,
                      productQuantity: controller.productQuantity.value,
                    );
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomButton(
                  width: Get.width * 0.4,
                  label: 'Buy Now',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
