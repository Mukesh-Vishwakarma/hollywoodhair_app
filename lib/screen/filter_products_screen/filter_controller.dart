import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/model/get_all_product_list_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/models.dart';
import '../../util/app_colors.dart';

class FilterProductController extends GetxController
    with GetTickerProviderStateMixin {
  var searchController = TextEditingController();
  var searchText = false.obs;
  final FocusNode focusNode = FocusNode();

  var productList = <GetAllProductData>[].obs;
  var isPageLoad = true.obs;
  var cateName = "".obs;
  var cateId = "".obs;
  var page = 1.obs;
  var isLoadPage = true.obs;

  RxList<Product> products = <Product>[].obs;
  RxList<Product> searchedProduct = <Product>[].obs;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments["products"] is RxList<Product>) {
      products.value = Get.arguments["products"];
      isPageLoad.value = false;
      print("skdzncxkn1==> ${products.value}");
      print("skdzncxkn1==> ${products.length}");
    } else {
      print("skdzncxkn2==> ${products.value}");
      isPageLoad.value = false;
    }
    super.onInit();
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

  void onSearchTextChanged(String text) {
    if (text.isEmpty) {
      searchedProduct.clear();
      return;
    }
    text = text.toLowerCase();
    final pattern = RegExp(text);

    searchedProduct.assignAll(
      products.where((product) {
        return pattern.hasMatch(product.title.toLowerCase());
      }).toList(),
    );
    searchedProduct.forEach((element) {
      print("list print ${element.title}");
    });
  }
}
