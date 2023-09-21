import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/model/shopify_model/category_model.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/models/src/product/products/products.dart';
import 'package:shopify_flutter/shopify/shopify.dart';
import 'package:sizer/sizer.dart';

import '../../../util/app_colors.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  var searchController = TextEditingController();

  var selectCategories = RxInt(-1);
  var categoriesId = 0.obs;
  RxList<Product> topProduct = <Product>[].obs;

  var categories = <CustomCollections>[].obs;

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
      print("collection ${collection}");
      collectionList.value = [];
      collectionList.add(Collection(
          title: "All",
          id: "ALL",
          products: Products(productList: [], hasNextPage: false)));
      collection.forEach((element) {
        collectionList.add(element);
        print("objectdhsjhx==> $element");
      });
    } on HttpException catch (exception) {
      print(exception.message);
    } catch (exception) {
      print(exception.toString());
    }
  }



  getTopProductApi() async {
    try {
      List<Product>? _product = await shopifyStore.getNProducts(6);
      topProduct.value = [];
      topProduct.value = _product!;
    } on HttpException catch (exception) {
      print(exception.message);
    } catch (exception) {
      print(exception.toString());
    }
  }


  networkImageWithLoader({required userProfile, height, width}) {
    return Image.network(
      userProfile,
      fit: BoxFit.cover,
      width: 50.w,
      height: 17.h,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Shimmer.fromColors(
          baseColor: const Color.fromRGBO(191, 191, 191, 0.5254901960784314),
          highlightColor: Colors.white,
          child: Container(
              width: 50.w,
              height: 17.h,
            color: Colors.grey,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Container(
          width: 50.w,
          height: 17.h,
          color: AppColors.lightGrey,
          child: const Icon(
            Icons.image_not_supported,
            color: Colors.white,
            size: 30,
          ), // You can use any widget as a placeholder
        );
      },
    );
  }


  networkImageCategory({required userProfile, height, width}) {
    return Image.network(
      userProfile,
      fit: BoxFit.cover,
      width: 55,
      height: 55,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Shimmer.fromColors(
          baseColor: const Color.fromRGBO(191, 191, 191, 0.5254901960784314),
          highlightColor: Colors.white,
          child: Container(
            width: 55,
            height: 55,
            color: Colors.grey,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Container(
          width: 55,
          height: 55,
          color: AppColors.lightGrey,
          child: const Icon(
            Icons.image_not_supported,
            color: Colors.white,
            size: 30,
          ), // You can use any widget as a placeholder
        );
      },
    );
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
