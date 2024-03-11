import 'dart:convert';

import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/data/models/cart_product.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/utils/memory_management.dart';

class UserCartController extends GetxController {
  final count = 0.obs;
  var total = 0.obs;
  List<CartProduct> cartProducts = [];
  RxList<CartProduct> selectedCartProducts = RxList<CartProduct>();

  @override
  void onInit() {
    super.onInit();
    getSavedCartProducts();
    updateCartTotal();
  }

  void getSavedCartProducts() {
    var localCart =
        jsonDecode(MemoryManagement.getMyCart() ?? '[]') as List<dynamic>;
    this.cartProducts = localCart
        .map(
          (e) => CartProduct(
            product: Product.fromJson(e['product']),
            productQuantity: e['productQuantity'] ?? 1,
          ),
        )
        .toList();
    updateCartTotal();
  }

  void saveCartProducts() {
    MemoryManagement.setMyCart(
      jsonEncode(
        cartProducts
            .map((e) =>
                {'product': e.product.toJson(), 'productQuantity': e.productQuantity})
            .toList(),
      ),
    );
  }

  void increaseProductQuantity(int index) {
    cartProducts[index].productQuantity++;
    saveCartProducts();
    updateCartTotal();
    update();
  }

  void decreaseQuantity(int index) {
    if (cartProducts[index].productQuantity <= 1) {
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: 'Info',
        message: "Cannot set quantity less than zero",
      );
      return;
    }
    cartProducts[index].productQuantity--;
    saveCartProducts();
    updateCartTotal();
    update();
  }

  void updateCartTotal() {
    total.value = 0;
    selectedCartProducts.forEach(
      (element) {
        total.value = total.value +
            element.product.productPrice! * element.productQuantity;
      },
    );
  }

  void updateSelectedProduct(int index, bool selected) {
    CartProduct product = cartProducts[index];
    product.selected = selected;

    if (selected) {
      if (!selectedCartProducts.contains(product)) {
        selectedCartProducts.add(product);
      }
    } else {
      selectedCartProducts.remove(product);
    }
    updateCartTotal();
    update();
  }

  void addToCart({required Product product, int? productQuantity}) {
    if (cartProducts
        .any((element) => element.product.productId == product.productId)) {
      CustomSnackbar.infoSnackbar(
        context: Get.context,
        title: 'Info',
        message: 'Product already in cart!',
      );
      return;
    }

    cartProducts.add(
      CartProduct(
        product: product,
        productQuantity: productQuantity ?? 1,
      ),
    );
    CustomSnackbar.successSnackbar(
      context: Get.context,
      title: 'Success',
      message: 'Added to cart!',
    );
    updateCartTotal();
    saveCartProducts();
    update();
  }

  void removeFromCart(int index) {
    selectedCartProducts.remove(cartProducts.elementAt(index));
    cartProducts.removeAt(index);
    saveCartProducts();

    updateCartTotal();
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
