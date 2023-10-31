import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

import '../../../product_details/product_details_controller.dart';

class SearchProductController extends GetxController {
  var listScrollController = ScrollController().obs;
  var searchController = TextEditingController();
  var searchText = false.obs;
  var page = 1.obs;
  var isPageLoad = false.obs;
  var isLoadPage = true.obs;
  final FocusNode focusNode = FocusNode();
  ShopifyStore shopifyStore = ShopifyStore.instance;
  RxList<Product> searchedProduct = <Product>[].obs;

  @override
  void onInit() {
    focusNode.requestFocus();
    super.onInit();
  }

  searchProducts(query) async {
    try {
      isLoadPage.value = false;
      List<Product> products =
          await shopifyStore.getAllProductsOnQuery("", query);
      searchedProduct.value = [];
      if (products.isNotEmpty) {
        searchedProduct.value = products;
        isLoadPage.value = false;
      }
    } catch (error) {
      debugPrint('message: $error');
    }
  }

  @override
  void dispose() {
    listScrollController.value.dispose();
    // focusNode.dispose();
    super.dispose();
  }

  getFindController() {
    try {
      Get.find<ProductDetailsController>().onInit();
    } catch (e) {
      print("kjashb $e");
    }
  }
}
