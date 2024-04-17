import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/modules/user_cart/controllers/user_cart_controller.dart';
import 'package:happytails/app/utils/asset_files.dart';
import 'package:happytails/app/utils/constants.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var userCartController = Get.put(UserCartController());
    return GestureDetector(
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Hero(
                  tag: 'product+${product.productId}',
                  // tag: 'product',
                  child: product.productImage == null
                      ? Image.asset(AssetFile.cartProductImage)
                      : Image.network(
                          getImage(
                            product.productImage,
                          ),
                          width: 200,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName?.toUpperCase() ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text(
                        //   product.sellerName.toString(),
                        //   style: const TextStyle(
                        //     fontSize: 10,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs${product.productPrice ?? ''}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            userCartController.addToCart(product: product);
                          },
                          child: const Icon(Icons.add_shopping_cart),
                        ),
                      ],
                    )
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
