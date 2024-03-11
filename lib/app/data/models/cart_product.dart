import 'package:happytails/app/data/models/product.dart';

class CartProduct {
  final Product product;
  bool selected;
  int productQuantity;

  CartProduct({
    required this.product,
    this.selected = false,
    this.productQuantity = 1,
  });
}
