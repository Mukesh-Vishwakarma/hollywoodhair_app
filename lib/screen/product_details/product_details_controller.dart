import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/api_provider/api_provider.dart';
import 'package:hollywood_hair/model/product_by_id_model.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

import '../../model/metafilds_details_model.dart';
import '../../translater_service/translatter_service.dart';

class ProductDetailsController extends GetxController {
  var current = 0.obs;
  final CarouselController controller = CarouselController();
  var imageProductList = <Images>[].obs;
  var productDetailsList = <ProductData>[].obs;
  RxBool addButtonStatus = false.obs;

  // var productReviewsList = <Review>[].obs;
  var metaFieldsDetails = MetaFieldsDetails().obs;

  var productId = "".obs;
  var varientId = 0.obs;
  RxList<Product> products = <Product>[].obs;
  ShopifyStore shopifyStore = ShopifyStore.instance;
  ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
  var dataIsLoading = true.obs;

  final TranslationService translationService = TranslationService();

  // Instead of this line:
// var dataIsLoading = true.obs;

// You should define the products list:
  var rootInfo = RootInfo('', []).obs;

  @override
  void onInit() {
    productId.value = Get.arguments['product_id'] ?? "";
    print("${productId.value}");

    checkIfExitsCart();
    getProductDetails();
    super.onInit();
  }

  Future<void> checkIfExitsCart() async {
    try {
      String checkoutId = GetStorage().read(AppConstants.checkOutID) ?? "";
      if (checkoutId.isNotEmpty) {
        Checkout _checkout = await shopifyCheckout
            .getCheckoutInfoQuery(checkoutId, getShippingInfo: false);
        _checkout.lineItems.forEach((element) {
          if (element.variant!.product!.id == productId.value) {
            addButtonStatus.value = true;
          }
        });
      }
    } catch (error) {}
  }

  getProductDetails() async {
    try {
      List<Product>? _products =
          await shopifyStore.getProductsByIds([productId.value]);
      products.value = _products!;

      productDetailsApi();

      dataIsLoading.value = false;
    } catch (e) {
      print("message: $e");
    }
  }

  late List<Widget> imageSliders = imageProductList.value
      .map((item) => Stack(
            children: <Widget>[
              Image.network(
                item.src.toString(),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 320,
              ),
            ],
          ))
      .toList()
      .obs;

  // ******* add to cart

  addToCart({variantId, id, title}) async {
    try {
      var checkOutID = await GetStorage().read(AppConstants.checkOutID) ?? "";
      ShopifyUser? shopifyUser = await ShopifyAuth.instance.currentUser();
      GetStorage()
          .write(AppConstants.userNameShopify, shopifyUser!.displayName);
      GetStorage().write(AppConstants.emailShopify, shopifyUser.email);
      GetStorage().write(AppConstants.tokenShopify,
          await ShopifyAuth.instance.currentCustomerAccessToken);
      var customerAccessToken = GetStorage().read(AppConstants.tokenShopify);
      var email = GetStorage().read(AppConstants.emailShopify);

      if (checkOutID == "") {
        final checkout = await shopifyCheckout.createCheckout(
          lineItems: [
            LineItem(variantId: variantId, title: title, quantity: 1, id: id)
          ],
          email: email,
        );

        shopifyCheckout
            .checkoutCustomerAssociate(
          checkout.id,
          customerAccessToken,
        )
            .then((value) async {
          GetStorage().write(AppConstants.checkOutID, checkout.id);
          addButtonStatus.value = true;
        });
      } else {
        final checkout = await shopifyCheckout.addLineItemsToCheckout(
          checkoutId: checkOutID,
          lineItems: [
            LineItem(variantId: variantId, title: title, quantity: 1, id: id)
          ],
        );
        addButtonStatus.value = true;
      }

      // shopifyCheckout
      //     .checkoutCustomerAssociate(
      //         checkout.id, 'dfa46d08f56c6067d80fd748ed0abad9')
      //     .then((value) {
      //   shopifyCheckout
      //       .getCheckoutInfoQuery(checkout.id,
      //           getShippingInfo: false, withPaymentId: false)
      //       .then((value) {
      //     print(value);
      //   });
      // shopifyCheckout
      //     .getAllOrders("dfa46d08f56c6067d80fd748ed0abad9")
      //     .then((value) {
      //   print("kamal");
      //   print(value!.length);
      // });
      //   dio.FormData params =
      //       dio.FormData.fromMap({'id': varientId.value, 'quantity': "1"});
      //
      //   AddCartModel addCartModel =
      //       await ApiProvider.shopifyCustomer().funAddToCart(params);
      //   print("add to cart product >>>> ${addCartModel.quantity.toString()}");
      //
      //   Get.offAllNamed(AppPages.baseScreen,
      //       arguments: {"screenType": "product details"});
      // } on HttpException catch (exception) {
      //   // progressDialog.dismiss();
      //   print(exception.message);
      // isPageLoad.value = false;
      // failedToast(exception.message);
    } catch (exception) {
      // progressDialog.dismiss();
      print(exception.toString());
      // isPageLoad.value = false;
      // failedToast(exception.toString());
    }
  }

  //  ****** product Details api

  productDetailsApi() async {
    try {
      MetaFieldsDetails metaFieldsDetailsModal = await ApiProvider.shopify()
          .funMetaFieldsDetailsShopify(
              productId.value.toString().split('/').last);

      metaFieldsDetails.value = metaFieldsDetailsModal;

      try {
        for (int i = 0; i < metaFieldsDetails.value.metafields!.length; i++) {
          if (metaFieldsDetails.value.metafields![i].key ==
              "product_features") {
            parseCode(metaFieldsDetails.value.metafields![i].value.toString());
          }
        }
      } catch (e) {
        print("ljdfsmkdsmx==> $e");
      }
    } on HttpException catch (exception) {
      print(exception.message);
    } catch (exception) {
      print(exception.toString());
    }
  }

  parseCode(value) {
    try {
      Map<String, dynamic> parsedJson = jsonDecode(value);
      rootInfo.value = RootInfo.fromJson(parsedJson);

      // Access values in the Dart model
      for (var paragraph in rootInfo.value.children) {
        for (var textInfo in paragraph.children) {}
      }
    } catch (e) {
      print("jsbdnzK==> $e");
    }
  }
}

class TextInfo {
  String type;
  String value;
  bool? bold;

  TextInfo(this.type, this.value, this.bold);

  factory TextInfo.fromJson(Map<String, dynamic> json) {
    return TextInfo(
      json['type'],
      json['value'],
      json['bold'],
    );
  }
}

class ParagraphInfo {
  String type;
  List<TextInfo> children;

  ParagraphInfo(this.type, this.children);

  factory ParagraphInfo.fromJson(Map<String, dynamic> json) {
    var childrenList = json['children'] as List;
    List<TextInfo> children =
        childrenList.map((item) => TextInfo.fromJson(item)).toList();

    return ParagraphInfo(
      json['type'],
      children,
    );
  }
}

class RootInfo {
  String type;
  List<ParagraphInfo> children;

  RootInfo(this.type, this.children);

  factory RootInfo.fromJson(Map<String, dynamic> json) {
    var childrenList = json['children'] as List;
    List<ParagraphInfo> children =
        childrenList.map((item) => ParagraphInfo.fromJson(item)).toList();

    return RootInfo(
      json['type'],
      children,
    );
  }
}

class ProductContent {
  final String description;
  final String ingredients;

  ProductContent({required this.description, required this.ingredients});

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'ingredients': ingredients,
    };
  }
}
