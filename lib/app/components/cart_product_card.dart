import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/data/models/cart_product.dart';
import 'package:happytails/app/modules/user_cart/controllers/user_cart_controller.dart';
import 'package:happytails/app/utils/asset_files.dart';
import 'package:happytails/app/utils/constants.dart';

class CartProductCard extends StatelessWidget {
  final CartProduct cartProduct;
  final int index;
  const CartProductCard(
      {super.key, required this.cartProduct, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<UserCartController>();
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
                child: cartProduct.product.productImage == null
                    ? Image.asset(
                        AssetFile.cartProductImage,
                        fit: BoxFit.cover,
                        height: double.infinity,
                      )
                    : Image.network(
                        getImage(
                          cartProduct.product.productImage,
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
                        cartProduct.product.productName ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Price: ${cartProduct.product.productPrice}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.decreaseQuantity(index);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            '${cartProduct.productQuantity}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.increaseProductQuantity(
                                index,
                                cartProduct.product,
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 52,
          child: IconButton(
            onPressed: () {
              controller.removeFromCart(index);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
