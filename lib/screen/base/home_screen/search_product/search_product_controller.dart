import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

import '../../../../util/app_colors.dart';
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

  networkImageWithLoader({required userProfile, height, width}) {
    return Image.network(
      userProfile,
      fit: BoxFit.cover,
      width: 12.h,
      height: 12.h,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Shimmer.fromColors(
          baseColor: const Color.fromRGBO(191, 191, 191, 0.5254901960784314),
          highlightColor: Colors.white,
          child: Container(
            width: 12.h,
            height: 12.h,
            color: Colors.grey,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Container(
          width: 12.h,
          height: 12.h,
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
