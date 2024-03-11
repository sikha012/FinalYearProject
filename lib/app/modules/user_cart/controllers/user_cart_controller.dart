import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_snackbar.dart';
import 'package:happytails/app/data/models/cart_product.dart';
import 'package:happytails/app/data/models/order.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/data/provider/order_services.dart';
import 'package:happytails/app/modules/main/views/main_view.dart';
import 'package:happytails/app/utils/memory_management.dart';

class UserCartController extends GetxController {
  final count = 0.obs;
  var total = 0.obs;

  RxList<CartProduct> cartProducts = RxList<CartProduct>();
  RxList<CartProduct> selectedCartProducts = RxList<CartProduct>();

  OrderService order = OrderService();

  Order? orderMade;

  @override
  void onInit() {
    super.onInit();
    getSavedCartProducts();
    updateCartTotal();
  }

  void getSavedCartProducts() {
    var localCart =
        jsonDecode(MemoryManagement.getMyCart() ?? '[]') as List<dynamic>;
    this.cartProducts.value = localCart
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
            .map((e) => {
                  'product': e.product.toJson(),
                  'productQuantity': e.productQuantity
                })
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
            (element.product.productPrice ?? 0) * element.productQuantity;
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

  void makeOrder() async {
    try {
      List<Map<String, dynamic>> cartProducts =
          selectedCartProducts.map((item) {
        return {
          "product": {
            "product_id": item.product.productId,
            "product_name": item.product.productName,
            "product_price": item.product.productPrice,
            "productstock_quantity": item.product.productstockQuantity,
            "product_description": item.product.productDescription,
            "product_image": item.product.productImage,
            "petcategory_id": item.product.petcategoryId,
            "productcategory_id": item.product.productcategoryId,
            "seller_id": item.product.sellerId,
            "petcategory_name": item.product.petcategoryName,
            "productcategory_name": item.product.productcategoryName,
            "seller_name": item.product.sellerName
          },
          "isSelected": item.selected,
          "quantity": item.productQuantity,
        };
      }).toList();

      await order
          .createOrder(
        userId: await MemoryManagement.getUserId() ?? 0,
        totalAmount: total.value,
        cartItems: cartProducts,
      )
          .then((value) {
        orderMade = value;
        CustomSnackbar.successSnackbar(
          context: Get.context,
          title: 'Success',
          message: 'Order created successfully',
        );
        debugPrint(value.orderId.toString());
        debugPrint(value.order?.orderStatus);
        Get.to(() => const MainView());
        // Get.to(
        //   () => const OrderSummaryView(),
        //   arguments: {
        //     'orderedItems': selectedCartItems,
        //     'orderId': createdOrderId.value.toString()
        //   },
        // );
      }).onError((error, stackTrace) {
        CustomSnackbar.errorSnackbar(
          context: Get.context,
          title: 'Error',
          message: error.toString(),
        );
      });
    } catch (e) {
      CustomSnackbar.errorSnackbar(
        context: Get.context,
        title: 'Exception',
        message: e.toString(),
      );
    }
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
