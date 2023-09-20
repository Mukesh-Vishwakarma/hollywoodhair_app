import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/api_provider/api_provider.dart';
import 'package:hollywood_hair/model/get_all_product_list_model.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class AllProductController extends GetxController
    with GetTickerProviderStateMixin {
  var searchController = TextEditingController();

  var productList = <GetAllProductData>[].obs;
  var isPageLoad = true.obs;
  var cateName = "".obs;
  var cateId = "".obs;
  ShopifyStore shopifyStore = ShopifyStore.instance;
  RxList<Product> products = <Product>[].obs;

  @override
  void onInit() {
    cateName.value = Get.arguments['categoryName'] ?? "";
    cateId.value = Get.arguments['categoryId'] ?? "";
    print(cateId.value);
    if (cateId.value == "ALL") {
      getAllProduct();
    } else {
      getCollectionProduct();
    }

    super.onInit();
  }

  getAllProduct() async {
    try {
      List<Product> _products = await shopifyStore.getAllProducts();
      isPageLoad.value = false;
      products.value = _products;
    } catch (e) {
      print("message: $e");
    }
  }

  getCollectionProduct() async {
    try {
      List<Product> _products =
          await shopifyStore.getAllProductsFromCollectionById(cateId.value);
      isPageLoad.value = false;
      products.value = _products;
    } catch (e) {
      print("message: $e");
    }
  }

  //  ****** all product list

  allProductApi() async {
    try {
      GetAllProductModel getAllProductModel =
          await ApiProvider.shopify().funProductListShopify(
        cateId.value,
      );

      isPageLoad.value = false;
      // progressDialog.dismiss();
      print('create Data');
      print(getAllProductModel.products);
      productList.value = getAllProductModel.products!;
      print("length product list >>> ${productList.length}");
    } on HttpException catch (exception) {
      // progressDialog.dismiss();
      print(exception.message);
      isPageLoad.value = false;
      // failedToast(exception.message);
    } catch (exception) {
      // progressDialog.dismiss();
      print(exception.toString());
      isPageLoad.value = false;
      // failedToast(exception.toString());
    }
  }
}
