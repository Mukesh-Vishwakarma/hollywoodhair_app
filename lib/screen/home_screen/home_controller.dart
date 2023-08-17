import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  var searchController = TextEditingController();

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}

class CategoriesModel {
  final String value;

   bool selected=false;

  CategoriesModel({required this.value, required this.selected});
}

class ProductModel {
  String title = "";
  bool selected = false;
  bool price = false;
  bool oldPrice = false;

  ProductModel({required value, required selected}) {
    this.title = value;
    this.selected = selected;
  }
}
