import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/model/shopify_model/category_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/src/product/products/products.dart';
import 'package:sizer/sizer.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

import '../../../util/app_colors.dart';
import '../../product_details/product_details_controller.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  var searchController = TextEditingController();
  final GlobalKey <ScaffoldState> key = GlobalKey();
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
    // getTopshopifyBlog();
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

  // getTopshopifyBlog() async {
  //   try {
  //
  //     print("sajdbjxnj===>  ");
  //     List<Blog>? _product = await shopifyBlog.getAllBlogs();
  //
  //     print("sajdbjxnj===>  $_product");
  //
  //   } on HttpException catch (exception) {
  //     print(exception.message);
  //   } catch (exception) {
  //     print(exception.toString());
  //   }
  // }


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

  getFindController() {
    try {
      Get.find<ProductDetailsController>().onInit();
    } catch (e){
      print("kjashb $e");
    }
  }

  // final shopify = Shopify(
  //   apiKey: 'YOUR_SHOPIFY_API_KEY',
  //   password: 'YOUR_SHOPIFY_PASSWORD',
  //   store: 'YOUR_SHOPIFY_STORE_NAME',
  //   domain: 'YOUR_SHOPIFY_DOMAIN',
  // );
  //
  // Future<void> fetchHomeBanner() async {
  //   final query = r'''
  //   {
  //     shop {
  //       homeBanner {
  //         id
  //         image {
  //           originalSrc
  //         }
  //         title
  //         subtitle
  //         buttonText
  //         buttonLink
  //       }
  //     }
  //   }
  // ''';
  //
  //   final result = await shopify.query(query);
  //   final homeBannerData = result.data['shop']['homeBanner'];
  //
  //   // You can now use the homeBannerData in your UI.
  //   print('Home Banner Data: $homeBannerData');
  // }


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
