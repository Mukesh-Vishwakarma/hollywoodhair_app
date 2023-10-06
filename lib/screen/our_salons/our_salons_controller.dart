import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/api_provider/api_provider.dart';
import 'package:hollywood_hair/model/get_all_product_list_model.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

import '../../model/salon_model.dart';
import '../../util/app_colors.dart';

class OurSalonsController extends GetxController {
  // var searchController = TextEditingController();

  // var productList = <GetAllProductData>[].obs;
  // var isPageLoad = true.obs;
  // var cateName = "All".obs;
  // var cateId = "1".obs;
  // ShopifyStore shopifyStore = ShopifyStore.instance;
  // RxList<Product> products = <Product>[].obs;

  List<SalonModel> salons= <SalonModel>[
    SalonModel(
      image: Assets.salon1,
      address: "Belwederska 44, 00-594 Warszawa",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon2,
      address: "Wilcza 2/4 00-532 Warszawa",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon3,
      address: "Jana III Sobieskiego 102A 00-764 Warszawa",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon4,
      address: "Aleja Niepodległości 727 81-840 Sopot",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon5,
      address: "plac Wolności 7, 61-738 Poznań",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon6,
      address: "Altus, Uniwersytecka 13 40-007 Katowice",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon7,
      address: "Plac Kościuszki 5,50-438 Wrocław",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon8,
      address: "Street Krzywoustego 80, 70-245 Szczecin",
      location: "Location",
    ),
    SalonModel(
      image: Assets.salon9,
      address: "Zwierzyniecka 30/5,31-105 Kraków",
      location: "Location",
    ),
  ];


  @override
  void onInit() {
    // cateName.value = Get.arguments['All'] ?? "";
    // cateId.value = Get.arguments['1'] ?? "";
    // print(cateId.value);
    // if (cateId.value == "ALL") {
    //   getAllProduct();
    // } else {
    //   getCollectionProduct();
    // }

    super.onInit();
  }

  // getAllProduct() async {
  //   try {
  //     List<Product> _products = await shopifyStore.getAllProducts();
  //     isPageLoad.value = false;
  //     products.value = _products;
  //   } catch (e) {
  //     print("message: $e");
  //   }
  // }

  // getCollectionProduct() async {
  //   try {
  //     List<Product> _products =
  //         await shopifyStore.getAllProductsFromCollectionById(cateId.value);
  //     isPageLoad.value = false;
  //     products.value = _products;
  //   } catch (e) {
  //     print("message: $e");
  //   }
  // }

  //  ****** all product list

  // allProductApi() async {
  //   try {
  //     GetAllProductModel getAllProductModel =
  //         await ApiProvider.shopify().funProductListShopify(
  //       cateId.value,
  //     );
  //
  //     isPageLoad.value = false;
  //     // progressDialog.dismiss();
  //     print('create Data');
  //     print(getAllProductModel.products);
  //     productList.value = getAllProductModel.products!;
  //     print("length product list >>> ${productList.length}");
  //   } on HttpException catch (exception) {
  //     // progressDialog.dismiss();
  //     print(exception.message);
  //     isPageLoad.value = false;
  //     // failedToast(exception.message);
  //   } catch (exception) {
  //     // progressDialog.dismiss();
  //     print(exception.toString());
  //     isPageLoad.value = false;
  //     // failedToast(exception.toString());
  //   }
  // }

  // networkImageWithLoader({required userProfile, height, width}) {
  //   return Image.network(
  //     userProfile,
  //     fit: BoxFit.cover,
  //     width: 50.w,
  //     height: 17.h,
  //     loadingBuilder: (BuildContext context, Widget child,
  //         ImageChunkEvent? loadingProgress) {
  //       if (loadingProgress == null) {
  //         return child;
  //       }
  //       return Shimmer.fromColors(
  //         baseColor: const Color.fromRGBO(191, 191, 191, 0.5254901960784314),
  //         highlightColor: Colors.white,
  //         child: Container(
  //           width: 50.w,
  //           height: 17.h,
  //           color: Colors.grey,
  //         ),
  //       );
  //     },
  //     errorBuilder:
  //         (BuildContext context, Object exception, StackTrace? stackTrace) {
  //       return Container(
  //         width: 50.w,
  //         height: 17.h,
  //         color: AppColors.lightGrey,
  //         child: const Icon(
  //           Icons.image_not_supported,
  //           color: Colors.white,
  //           size: 30,
  //         ), // You can use any widget as a placeholder
  //       );
  //     },
  //   );
  // }

}
