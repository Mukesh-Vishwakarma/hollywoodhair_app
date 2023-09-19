import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/api_provider/api_provider.dart';
import 'package:hollywood_hair/model/product_by_id_model.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class ProductDetailsController extends GetxController {
  var current = 0.obs;
  final CarouselController controller = CarouselController();
  var imageProductList = <Images>[].obs;
  var productDetailsList = <ProductData>[].obs;

  // var productReviewsList = <Review>[].obs;
  var productDetails = ProductDetailsModel().obs;

  var productId = "".obs;
  var varientId = 0.obs;
  RxList<Product> products = <Product>[].obs;
  ShopifyStore shopifyStore = ShopifyStore.instance;
  ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
  var dataIsLoading = true.obs;

  @override
  void onInit() {
    productId.value = Get.arguments['product_id'] ?? "";
    print("${productId.value}");
    // productDetailsApi();
    getProductDetails();
    // productDetailsApi();
    super.onInit();
  }

  getProductDetails() async {
    try {
      List<Product>? _products =
          await shopifyStore.getProductsByIds([productId.value]);

      products.value = _products!;
      dataIsLoading.value = false;
      // for (final product in products) {
      //   final rating = product.productVariants[0].customAttributes.firstWhere(
      //         (attribute) => attribute.key == 'rating', // Replace with your actual rating attribute key
      //     orElse: () => null,
      //   );
      //
      //   if (rating != null) {
      //     print('Product Title: ${product.title}');
      //     print('Product Rating: ${rating.value}');
      //   }
      // }
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
        print("checkout $checkout");
        shopifyCheckout
            .checkoutCustomerAssociate(
          checkout.id,
          customerAccessToken,
        )
            .then((value) async {
          GetStorage().write(AppConstants.checkOutID, checkout.id);
        });
      } else {
        print("part 2");
        final checkout = await shopifyCheckout.addLineItemsToCheckout(
          checkoutId: checkOutID,
          lineItems: [
            LineItem(variantId: variantId, title: title, quantity: 1, id: id)
          ],
        );
        print(checkout.lineItems.length);
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
      dio.FormData params = dio.FormData.fromMap({
        'product_id': productId.value.toString(),
      });
      print('product data by id');
      print(params.fields.toString());
      ProductDetailsModel productDetailsModel =
          await ApiProvider.shopify().funProductDetailsShopify("8678460686671");
      // isPageLoad.value = false;
      // progressDialog.dismiss();
      print('create Data');
      if (productDetailsModel.product?.variants != null) {
        varientId.value = productDetailsModel.product?.variants?[0].id ?? "";
      }
      print("product varient id >>>$varientId");
      // print(productDetailsModel.product!.variants[].id);
      // if (productByIDModel.product) {
      imageProductList.value = productDetailsModel.product!.images!;

      productDetails.value = productDetailsModel;
      // productReviewsList.value = productByIDModel.data!.review!;
      // print("productReviewsList >>>${productReviewsList.length}");

      // Get.back();
      // } else {
      //   // isPageLoad.value = false;
      //   // failedToast(userBean.msg!);
      // }
    } on HttpException catch (exception) {
      // progressDialog.dismiss();
      print(exception.message);
      // isPageLoad.value = false;
      // failedToast(exception.message);
    } catch (exception) {
      // progressDialog.dismiss();
      print(exception.toString());
      // isPageLoad.value = false;
      // failedToast(exception.toString());
    }
  }
}
