import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:happytails/app/components/customs/custom_button.dart';
import 'package:happytails/app/components/seller_product_card.dart';
import 'package:happytails/app/data/models/product.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/views/views/add_product_view.dart';
import 'package:happytails/app/views/views/update_product_view.dart';

import '../controllers/seller_products_controller.dart';

class SellerProductsView extends GetView<SellerProductsController> {
  const SellerProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SellerProductsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 9),
        //     child: Material(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(10),
        //       child: IconButton(
        //         onPressed: () {},
        //         icon: const Icon(
        //           Icons.add,
        //           color: Constants.primaryColor,
        //           size: 27,
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: GetBuilder<SellerProductsController>(
        builder: (controller) => Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: SearchView(),
                        );
                      },
                      child: Container(
                        width: 160,
                        height: 45,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.search,
                                size: 30,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Search...",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CustomButton(
                        label: 'Add new product',
                        disableBorder: false,
                        width: 200,
                        labelStyle: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () {
                          Get.to(() => const AddProductView());
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                controller.products.isEmpty
                    ? const Center(
                        child: Text(
                          "Add products to view here...",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) => SizedBox(
                          height: 125,
                          child: Stack(
                            children: [
                              SellerProductCard(
                                product: controller.products[index],
                                index: index,
                              ),
                              Positioned(
                                right: 10,
                                top: 15,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => const UpdateProductView(),
                                          arguments: {
                                            'product':
                                                controller.products[index],
                                          },
                                        );
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Icon(
                                          Icons.edit_note,
                                          size: 35,
                                          color: Constants.primaryColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.deleteProduct(
                                          controller.products[index],
                                        );
                                      },
                                      child: const Icon(
                                        Icons.delete_forever,
                                        size: 28,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
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

SellerProductsController controller = Get.find();

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> suggestions = [];
    suggestions = controller.products
        .where((element) =>
            element.productName?.toLowerCase().contains(query.toLowerCase()) ??
            false)
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: suggestions.length,
      itemBuilder: (context, index) => SizedBox(
        height: 100,
        child: SearchResultCard(product: suggestions[index]),
      ),
    );
  }
}

class SearchResultCard extends StatelessWidget {
  final Product product;
  const SearchResultCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(
        //   Routes.PRODUCT_DESCRIPTION,
        //   arguments: product,
        // );
        debugPrint(product.productId.toString());
      },
      child: Container(
        height: 75,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.network(
              getImage(product.productImage),
              width: 75,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              product.productName ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            // Spacer(),
            // LocalStorage.getAccessRole() == 'admin'
            //     ? IconButton(
            //         onPressed: () {
            //           showDialog(
            //               context: context,
            //               builder: (context) => DeleteProductDialog(
            //                     productId: product.productId ?? '',
            //                   ));
            //         },
            //         icon: Icon(
            //           Icons.delete,
            //           color: Colors.red,
            //         ),
            //       )
            //     : SizedBox()
          ],
        ),
      ),
    );
  }
}
