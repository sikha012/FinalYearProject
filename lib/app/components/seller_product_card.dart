import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/modules/seller_products/controllers/seller_products_controller.dart';
import 'package:happytails/app/utils/asset_files.dart';
import 'package:happytails/app/utils/constants.dart';

class SellerProductCard extends StatelessWidget {
  final Product product;
  final int index;
  const SellerProductCard({
    super.key,
    required this.product,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<SellerProductsController>();
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.only(bottom: 20),
          height: 120,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: product.productImage == null
                    ? Image.asset(
                        AssetFile.cartProductImage,
                        fit: BoxFit.cover,
                        height: double.infinity,
                      )
                    : Image.network(
                        getImage(
                          product.productImage,
                        ),
                        fit: BoxFit.contain,
                      ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        product.productName ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Price: ${product.productPrice}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Quantity in stock: ${product.productstockQuantity}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        // Positioned(
        //   right: 0,
        //   bottom: 52,
        //   child: IconButton(
        //     onPressed: () {
        //       controller.removeFromCart(index);
        //     },
        //     icon: const Icon(
        //       Icons.delete,
        //       color: Colors.red,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
