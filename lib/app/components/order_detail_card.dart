import 'package:flutter/material.dart';
import 'package:happytails/app/data/models/cart_product.dart';
import 'package:happytails/app/utils/asset_files.dart';
import 'package:happytails/app/utils/constants.dart';

class OrderDetailCard extends StatelessWidget {
  final CartProduct cartProduct;
  const OrderDetailCard({
    super.key,
    required this.cartProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 5,
            //     blurRadius: 7,
            //     offset: const Offset(0, 3),
            //   ),
            // ],
          ),
          margin: const EdgeInsets.only(bottom: 10),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      cartProduct.product.productName ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Price: ${cartProduct.product.productPrice}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Quantity x ${cartProduct.productQuantity}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Total Amount: ${cartProduct.product.productPrice! * cartProduct.productQuantity}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 75,
                child: cartProduct.product.productImage == null
                    ? Image.asset(
                        AssetFile.cartProductImage,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        getImage(
                          cartProduct.product.productImage,
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
