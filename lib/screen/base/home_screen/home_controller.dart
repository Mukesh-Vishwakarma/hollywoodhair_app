import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/model/shopify_model/category_model.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/models/src/product/products/products.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  var searchController = TextEditingController();

  var selectCategories = RxInt(-1);
  var categoriesId = 0.obs;
  RxList<Product> topProduct = <Product>[].obs;
  RxList<ProductModel> productList = <ProductModel>[
    ProductModel(
      selected: false,
      price: "zł 119.00",
      image: Assets.p1,
      oldPrice: "119.00",
      title: 'Scalp Peeling - Cleansing peeling for the scalp 500 ml',
    ),
    ProductModel(
      selected: false,
      price: "zł 119.00",
      image: Assets.p1,
      oldPrice: "119.00",
      title: 'Scalp Peeling - Cleansing peeling for the scalp 500 ml',
    ),
    ProductModel(
      selected: false,
      price: "zł 119.00",
      image: Assets.p2,
      oldPrice: "119.00",
      title: 'Scalp Peeling - Cleansing peeling for the scalp 500 ml',
    ),
    ProductModel(
      selected: false,
      price: "zł 119.00",
      image: Assets.p3,
      oldPrice: "119.00",
      title: 'Scalp Peeling - Cleansing peeling for the scalp 500 ml',
    ),
    ProductModel(
      selected: false,
      price: "zł 119.00",
      image: Assets.p4,
      oldPrice: "119.00",
      title: 'Scalp Peeling - Cleansing peeling for the scalp 500 ml',
    ),
    ProductModel(
      selected: false,
      price: "zł 119.00",
      image: Assets.p5,
      oldPrice: "119.00",
      title: 'Scalp Peeling - Cleansing peeling for the scalp 500 ml',
    ),
    ProductModel(
      selected: false,
      price: "zł 119.00",
      image: Assets.p6,
      oldPrice: "119.00",
      title: 'Scalp Peeling - Cleansing peeling for the scalp 500 ml',
    ),
  ].obs;
  var categories = <CustomCollections>[].obs;
  RxList<CategoriesModel> categoriesList = <CategoriesModel>[
    CategoriesModel(value: "All", selected: true),
    CategoriesModel(value: "Conditioner", selected: false),
    CategoriesModel(value: "Accessories", selected: false),
    CategoriesModel(value: "Accessories", selected: false),
    CategoriesModel(value: "Oils", selected: false),
    CategoriesModel(value: "Perfume", selected: false),
    CategoriesModel(value: "Supplements", selected: false),
    CategoriesModel(value: "Trichology", selected: false),
  ].obs;
  RxList<Collection> collectionList = <Collection>[
    Collection(
        title: "All",
        id: "ALL",
        products: Products(productList: [], hasNextPage: false))
  ].obs;
  var selectedCollection = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    categoriesListApi();
    getTopProductApi();
    super.onInit();
  }

  ShopifyStore shopifyStore = ShopifyStore.instance;

  categoriesListApi() async {
    try {
      List<Collection>? collection = await shopifyStore.getAllCollections();
      collectionList.value = [];
      collectionList.add(Collection(
          title: "All",
          id: "ALL",
          products: Products(productList: [], hasNextPage: false)));
      collection.forEach((element) {
        collectionList.add(element);
      });
    } on HttpException catch (exception) {
      print(exception.message);
    } catch (exception) {
      print(exception.toString());
    }
  }

  getTopProductApi() async {
    try {
      List<Product>? _product = await shopifyStore.getNProducts(10);
      topProduct.value = [];
      topProduct.value = _product!;
    } on HttpException catch (exception) {
      print(exception.message);
    } catch (exception) {
      print(exception.toString());
    }
  }
}

class CategoriesModel {
  final String value;

  bool selected = false;

  CategoriesModel({required this.value, required this.selected});
}

class ProductModel {
  String title = "";
  bool selected = false;
  String price = "";
  String oldPrice = "";
  String image = "";

  ProductModel(
      {required this.title,
      required this.selected,
      required this.price,
      required this.oldPrice,
      required this.image});
}
