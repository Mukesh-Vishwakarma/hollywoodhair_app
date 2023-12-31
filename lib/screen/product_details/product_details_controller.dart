import 'package:dio/dio.dart';
import 'package:hollywood_hair/model/collection_by_product_model.dart';
import 'package:hollywood_hair/model/relacted_product_model.dart';
import 'package:html/parser.dart';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:hollywood_hair/api_provider/api_provider.dart';
import 'package:hollywood_hair/model/product_by_id_model.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';
import 'dart:convert';
import '../../model/metafilds_details_model.dart';
import '../../translater_service/translatter_service.dart';
import '../../util/app_colors.dart';

class ProductDetailsController extends GetxController
    with WidgetsBindingObserver {
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
  var productsRelated = <EdgesThird>[].obs;
  ShopifyStore shopifyStore = ShopifyStore.instance;
  ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
  var dataIsLoading = true.obs;

  final TranslationService translationService = TranslationService();

  var testConvert = "".obs;
  var rootInfo = RootInfo('', []).obs;

  var isLoader = true.obs;

  var targetLanguage = TranslateLanguage.polish.obs;

  var htmlDescription = "".obs;
  var htmlDescriptionNew = "".obs;
  var productTitle = "".obs;

  var totalRating = '0'.obs;
  var totalRatingDouble = 0.0.obs;

  var htmlResponse;
  var title = ''.obs;

  RxList<Review> reviewList = <Review>[].obs;

  @override
  Future<void> onInit() async {
    productId.value = Get.arguments['product_id'] ?? "";
    print("jashdvhbh===> ${productId.value}");
    try {
      var checkOutID = await GetStorage().read(AppConstants.checkOutID) ?? "";
      if (checkOutID.toString() != "" && checkOutID != null) {
        checkIfExitsCart();
      } else {
        addButtonStatus.value = false;
      }
    } catch (e) {
      print("mdjbsnm $e");
    }
    getCollectionsIdByProductId(productId.value);
    getRelatedProductById(productId.value);
    getLanguage();
    productDetailsApi();
    getProductDetails();
    super.onInit();
  }

  Future<void> checkIfExitsCart() async {
    addButtonStatus.value = false;
    print("sajkjnmz===>");
    try {
      String checkoutId = GetStorage().read(AppConstants.checkOutID) ?? "";
      if (checkoutId.isNotEmpty) {
        Checkout _checkout = await shopifyCheckout
            .getCheckoutInfoQuery(checkoutId, getShippingInfo: false);
        for (var element in _checkout.lineItems) {
          if (element.variant!.product!.id == productId.value) {
            addButtonStatus.value = true;
            print("sajkjnmz===>  ${addButtonStatus.value}");
          }
          print("sajkjnmz===>  ${addButtonStatus.value}");
        }
      } else {
        print("sajkjnmz===>  ${addButtonStatus.value}");
        addButtonStatus.value = false;
      }
    } catch (error) {
      print("sajkjnmz===>  $error");
    }
  }

  getProductDetails() async {
    try {
      List<Product>? _products =
          await shopifyStore.getProductsByIds([productId.value]);
      products.value = _products!;

      productTitle.value = await translate(products.value[0].title.toString());
      String originalString =
          await translate(products[0].descriptionHtml!.toString());
      htmlDescription.value =
          originalString.replaceAll('/ ', '/'); // Replace '/' with a space

      print("ehsdjak==>  ${_products}");
      dataIsLoading.value = false;
    } catch (e) {
      dataIsLoading.value = false;
      print("messageskhb====> $e");
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

  //  ****** product Details api

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

  productDetailsApi() async {
    print("dkjsbjkkdshx====> ${productId.value}");

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

        for (int i = 0; i < metaFieldsDetails.value.metafields!.length; i++) {
          if (metaFieldsDetails.value.metafields![i].key == "rating") {
            Map<String, dynamic> jsonMap = jsonDecode(
                metaFieldsDetails.value.metafields![i].value.toString());

            totalRating.value = jsonMap['value'];
            totalRatingDouble.value = double.parse(totalRating.value);
          }
        }

        for (int i = 0; i < metaFieldsDetails.value.metafields!.length; i++) {
          if (metaFieldsDetails.value.metafields![i].key == "widget") {
            // Parse the HTML string using the html package
            var htmlDocument =
                parse(metaFieldsDetails.value.metafields![i].value);

            // Select reviews from the parsed document
            var reviews = htmlDocument.querySelectorAll('.jdgm-rev');

            print("dhjkxlzl==> $reviews");

            for (var review in reviews) {
              var authorName =
                  review.querySelector('.jdgm-rev__author')?.text?.trim();
              var reviewBody =
                  review.querySelector('.jdgm-rev__body p')?.text?.trim();
              var reviewTitle =
                  review.querySelector('.jdgm-rev__title')?.text?.trim();
              var reviewScore = review
                  .querySelector('.jdgm-rev__rating')
                  ?.attributes['data-score'];

              print('Author Name: $authorName');
              print('Review Body: $reviewBody');
              print('Review Title: $reviewTitle');
              print('Review Score: $reviewScore');

              if (authorName != null &&
                  reviewBody != null &&
                  reviewTitle != null &&
                  reviewScore != null) {
                reviewList.add(Review(
                    authorName: authorName,
                    reviewBody: reviewBody,
                    reviewTitle: reviewTitle,
                    reviewScore: reviewScore));
              }
            }
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

  // void parseHtmlResponse(String htmlResponse) {
  //   // Parse the HTML content
  //   var document = parse(htmlResponse);
  //
  //   // Extract and print the text content
  //   var textContent = document.body!.text;
  //   print(textContent.trim());
  // }

  // ******* add to cart

  addToCart({variantId, id, title}) async {
    isLoader.value = false;
    try {
      var checkOutID = await GetStorage().read(AppConstants.checkOutID) ?? "";
      var customerAccessToken = GetStorage().read(AppConstants.tokenShopify);
      var email = GetStorage().read(AppConstants.emailShopify);
      // print("kahbdsskljhbjb===> ${checkOutID.toString()}");

      try {
        ShopifyUser? shopifyUser = await ShopifyAuth.instance.currentUser();
        GetStorage()
            .write(AppConstants.userNameShopify, shopifyUser!.displayName);
        GetStorage().write(AppConstants.emailShopify, shopifyUser.email);
        GetStorage().write(AppConstants.tokenShopify,
            await ShopifyAuth.instance.currentCustomerAccessToken);
      } catch (e) {
        print("kahbdsskl===> 1 $e");
      }
      print("kahbdsskl===> 2 $checkOutID");

      if (checkOutID.toString() == "") {
        final checkout = await shopifyCheckout.createCheckout(
          lineItems: [
            LineItem(variantId: variantId, title: title, quantity: 1, id: id)
          ],
          email: email,
        );
        print("checkout $checkout");
        print("checkoutId=> ${checkout.id}");
        // shopifyCheckout.checkoutCustomerAssociate(checkout.id, customerAccessToken,).then((value) async {
        GetStorage().write(AppConstants.checkOutID, checkout.id);
        addButtonStatus.value = true;
        isLoader.value = true;
        // });
      } else {
        print("part 2");
        final checkout = await shopifyCheckout.addLineItemsToCheckout(
          checkoutId: checkOutID,
          lineItems: [
            LineItem(variantId: variantId, title: title, quantity: 1, id: id)
          ],
        );
        addButtonStatus.value = true;
        isLoader.value = true;
        print(checkout.lineItems.length);
      }
    } catch (exception) {
      isLoader.value = true;
      print("sahgbxzjkhn==> ${exception.toString()}");

      final exceptionString = exception.toString();
      final start = exceptionString.indexOf("message: ");
      if (start >= 0) {
        final end = exceptionString.indexOf(",", start);
        final errorMessage =
            exceptionString.substring(start + "message: ".length, end);
        if (errorMessage == "Checkout is already completed.") {
          GetStorage().write(AppConstants.checkOutID, "");
        }
        print("Exception Message: $errorMessage");
      } else {
        print("An unexpected error occurred.");
      }
    }
  }

  Future<String> translate(test) async {
    final targetLanguage =
        await getLanguage(); // Wait for getLanguage() to complete.

    final translatedText =
        await translationService.translate(test, targetLanguage);

    if (translatedText != null) {
      print("Translated Text: $translatedText");
      testConvert.value = translatedText.toString();
      return translatedText;
    } else {
      print("Translation failed ");
      return "inputWord";
    }
  }

  Future<TranslateLanguage> getLanguage() async {
    final languageCode = GetStorage().read(AppConstants.languageCode);
    if (languageCode != null) {
      if (languageCode == "English") {
        return TranslateLanguage.english;
      } else if (languageCode == "Polski") {
        return TranslateLanguage.polish;
      } else {
        return TranslateLanguage.spanish;
      }
    } else {
      return TranslateLanguage.polish;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("Lifecycle state changed to: $state");
    // Add other logic here
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if (state == AppLifecycleState.resumed) {
  //     print("hsbjxnaksnkxj");
  //     // productId.value = Get.arguments['product_id'] ?? "";
  //     // print("jashdvhbh===> ${productId.value}");
  //     // getLanguage();
  //     // productDetailsApi();
  //     // checkIfExitsCart();
  //     // getProductDetails();
  //     // productDetailsApi();
  //   } else if (state == AppLifecycleState.paused) {
  //
  //     print("hsbjxnaksnkxj");
  //     // productId.value = Get.arguments['product_id'] ?? "";
  //     // print("jashdvhbh===> ${productId.value}");
  //     // getLanguage();
  //     // productDetailsApi();
  //     // checkIfExitsCart();
  //     // getProductDetails();
  //     // // productDetailsApi();
  //   }
  // }

  parseCode(value) async {
    var valueText = await translate(value);

    print("jbzxjnknk===>> $valueText");

    try {
      Map<String, dynamic> parsedJson = jsonDecode(value);
      rootInfo.value = RootInfo.fromJson(parsedJson);

      // Access values in the Dart model
      print(rootInfo.value.type);
      for (var paragraph in rootInfo.value.children) {
        for (var textInfo in paragraph.children) {}
      }
    } catch (e) {
      print("jsbdnzK==> $e");
    }
  }

  getCollectionsIdByProductId(productId) async {
    try {
      print("gsdjhjk==> $productId");
      var data =
          '''{"query":"{ product(id: \\"$productId\\") { id title collections(first: 10) { edges { node { id title } } } } }","variables":{}}''';

      CollectionByProductModel collectionByProductModel =
          await ApiProvider.shopifyWithTokenDynamic()
              .getCollectionByProduct(data: data);

      title.value = await translate(collectionByProductModel
          .dataCollection!.productCollection!.collections!.edges![0].node!.title
          .toString());
    } catch (e) {
      print("fhsdjk==> $e");
    }
  }

  getRelatedProductById(productId) async {
    try {
      print("gsdjhjk==> $productId");
      // var data = '''{"query":"{ product(id: \\"$productId\\") { title collections(first: 1) { edges { node { products(first: 4) { edges { node { id title handle } } } } } } } }","variables":{}}''';


      var data = '''{"query":"{\\n  product(id: \\"$productId\\") {\\n    title\\n    variants(first: 1) {\\n      edges {\\n        node {\\n          priceV2 {\\n            amount\\n            currencyCode\\n          }\\n        }\\n      }\\n    }\\n    collections(first: 1) {\\n      edges {\\n        node {\\n          products(first: 4) {\\n            edges {\\n              node {\\n                id\\n                title\\n                handle\\n                images(first: 1) {\\n                  edges {\\n                    node {\\n                      originalSrc\\n                    }\\n                  }\\n                }\\n                variants(first: 1) {\\n                  edges {\\n                    node {\\n                      priceV2 {\\n                        amount\\n                        currencyCode\\n                      }\\n                    }\\n                  }\\n                }\\n              }\\n            }\\n          }\\n        }\\n      }\\n    }\\n  }\\n}\\n","variables":{}}''';

      RelatedProductModel relatedProductModel =
          await ApiProvider.shopifyWithTokenDynamic()
              .getRelatedProduct(data: data);


      // print("fjdhjk ${relatedProductModel.data!.product!.collections!.edgesSecond![0].nodeSecond!.products!.edgesThird![0].nodeThird!.title}");

      productsRelated.value = relatedProductModel.data!.product!.collections!.edgesSecond![0].nodeSecond!.products!.edgesThird!;

      // print("fjdhjk ${productsRelated.value[0].nodeThird!.title}");

      // title.value = await translate(collectionByProductModel
      //     .dataCollection!.productCollection!.collections!.edges![0].node!.title
      //     .toString());
    } catch (e) {
      print("fhsdjk==> $e");
    }
  }


  networkImageWithLoader({required userProfile, height, width}) {
    return Image.network(
      userProfile,
      fit: BoxFit.cover,
      width: 50.w,
      height: 16.h,
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

  getFindController() {
    try {
      Get.find<ProductDetailsController>().onInit();
    } catch (e) {
      print("kjashb $e");
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

class Review {
  String authorName;
  String reviewBody;
  String reviewTitle;
  String reviewScore;

  Review(
      {required this.authorName,
      required this.reviewBody,
      required this.reviewTitle,
      required this.reviewScore});
}
