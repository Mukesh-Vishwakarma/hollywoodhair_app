import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/screen/base/base_home_controller.dart';
import 'package:hollywood_hair/screen/base/cart_screen/cart_controller.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../util/theme_service.dart';
import 'product_details_controller.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ));

    return Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: AppBar(
            elevation: 0.4,
            titleSpacing: 0.0,
            backgroundColor: AppColors.colorFF,
            leading: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Set the same rounded border as Material
                ),
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                )),
            title: Text("Product details",
                style: AppStyles.textStyle(
                    fontSize: 18.0, weight: FontWeight.w500)),
            automaticallyImplyLeading: false,
            /*actions: const [
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed(AppPages.favouriteScreen);
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(right: 20.0),
              //     child: SvgPicture.asset(Assets.favouriteIcon),
              //   ),
              // ),
              *//* InkWell(
                onTap: () {
                  // controller.addToCartUpdateAddress();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SvgPicture.asset(Assets.searchIcon),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppPages.allProductScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SvgPicture.asset(Assets.notificationIcon),
                ),
              ),*//*
            ],*/
          ),
        ),
        body: Stack(
          children: [
            Obx(
              () => controller.dataIsLoading.isFalse
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 320,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 320,
                                      child: CarouselSlider(
                                        // items: controller.imageSliders,
                                        carouselController:
                                            controller.controller,
                                        options: CarouselOptions(
                                            autoPlay: true,
                                            disableCenter: true,
                                            viewportFraction: 1,
                                            onPageChanged: (index, reason) {
                                              controller.current.value = index;
                                            }),
                                        items: controller
                                            .products.value[0].images
                                            .map((url) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                // margin: EdgeInsets.symmetric(horizontal: 5.0),
                                                decoration: const BoxDecoration(
                                                  color: Colors.grey,
                                                ),
                                                child: Image.network(
                                                    url.originalSrc,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: 320),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    // Obx(() => Container(
                                    //       alignment: Alignment.bottomCenter,
                                    //       margin: const EdgeInsets.only(bottom: 15),
                                    //       child: Row(
                                    //         mainAxisAlignment: MainAxisAlignment.center,
                                    //         children: controller.products.value[0].images
                                    //             .map((entry) {
                                    //           return GestureDetector(
                                    //             onTap: () {
                                    //               controller.controller
                                    //                   .animateToPage(entry.id.t);
                                    //             },
                                    //             child: Container(
                                    //               width: (controller.current.value ==
                                    //                       entry.key
                                    //                   ? 15.0
                                    //                   : 6.0),
                                    //               height: 6.0,
                                    //               margin: const EdgeInsets.symmetric(
                                    //                 vertical: 0.0,
                                    //                 horizontal: 2.0,
                                    //               ),
                                    //               decoration: BoxDecoration(
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(20),
                                    //                   color: controller.current.value ==
                                    //                           entry.key
                                    //                       ? AppColors.primaryColorDark
                                    //                       : Colors.white,
                                    //                   border: Border.all(
                                    //                       color: AppColors.color61,
                                    //                       width: 0.1)),
                                    //             ),
                                    //           );
                                    //         }).toList(),
                                    //       ),
                                    //     )),
                                  ],
                                ),
                              ),

                              Obx(() => controller.products.value[0].title !=
                                      null
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15, top: 10),
                                      child: Text(
                                        controller.products.value[0].title ??
                                            "",
                                        style: AppStyles.textStyle(
                                          weight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    )
                                  : const SizedBox()),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10),
                                    child: Text(
                                      controller.products.value[0]
                                              .formattedPrice ??
                                          "",
                                      // "Scalp Peeling - Cleansing peeling for the scalp",
                                      style: AppStyles.textStyle(
                                        weight: FontWeight.w500,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 14),
                                      child: Text(
                                        controller.products.value[0]
                                            .compareAtPriceFormatted,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13.0,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )),
                                ],
                              ),

                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(left: 20, top: 10),
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       RatingBar.builder(
                              //         initialRating: 1,
                              //         minRating: 1,
                              //         direction: Axis.horizontal,
                              //         allowHalfRating: true,
                              //         itemSize: 15.5,
                              //         itemCount: 1,
                              //         itemPadding:
                              //             const EdgeInsets.symmetric(horizontal: 2.0),
                              //         itemBuilder: (context, _) => const Icon(
                              //           Icons.star,
                              //           color: Colors.amber,
                              //           size: 2,
                              //         ),
                              //         onRatingUpdate: (rating) {
                              //           print(rating);
                              //         },
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(
                              //             left: 4, top: 0),
                              //         child: Text("}",
                              //             style: AppStyles.textStyle(
                              //               weight: FontWeight.w500,
                              //               fontSize: 14.0,
                              //             )),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(
                              //             left: 7, top: 0),
                              //         child: Text('(132 Rating)',
                              //             style: AppStyles.textStyle(
                              //               weight: FontWeight.normal,
                              //               color: AppColors.gray99,
                              //               fontSize: 14.0,
                              //             )),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(
                                    thickness: 1.0,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 0),
                                    child: Text(
                                      "Product Details",
                                      style: AppStyles.textStyle(
                                        weight: FontWeight.w500,
                                        fontSize: dimen15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    // height: 500,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .rootInfo.value.children.length,
                                          itemBuilder: (context, index) {
                                            final paragraph = controller
                                                .rootInfo.value.children[index];

                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 8),
                                                FutureBuilder<List<String>>(
                                                  future: Future.wait(paragraph
                                                      .children
                                                      .map((textInfo) {
                                                    return controller.translate(
                                                        textInfo.value);
                                                  })),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      final translatedTexts =
                                                          snapshot.data ??
                                                              []; // List of translated texts.
                                                      final concatenatedText =
                                                          translatedTexts.join(
                                                              ''); // Join the translated texts with no spaces in between.

                                                      final textSpans =
                                                          <TextSpan>[];
                                                      for (int i = 0;
                                                          i <
                                                              paragraph.children
                                                                  .length;
                                                          i++) {
                                                        final textInfo =
                                                            paragraph
                                                                .children[i];
                                                        final translatedText =
                                                            translatedTexts[i];

                                                        final fontWeight =
                                                            textInfo.bold ??
                                                                    false
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal;

                                                        textSpans.add(
                                                          TextSpan(
                                                            text:
                                                                translatedText,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  fontWeight,
                                                              height: 1.6,
                                                              wordSpacing: 0.6,
                                                            ),
                                                          ),
                                                        );
                                                      }

                                                      return RichText(
                                                        text: TextSpan(
                                                          style: DefaultTextStyle
                                                                  .of(context)
                                                              .style,
                                                          children: textSpans,
                                                        ),
                                                      );
                                                    } else {
                                                      return Container();
                                                      // return shimmerDemoTranslate();
                                                      // return CircularProgressIndicator();
                                                    }
                                                  },
                                                ),
                                                const SizedBox(height: 16),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const Divider(
                                thickness: 1.0,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10),
                                child: Text(
                                  "OPIS".tr,
                                  style: AppStyles.textStyle(
                                    weight: FontWeight.w500,
                                    fontSize: dimen15,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                child: Html(
                                  data: controller.products[0].descriptionHtml!,
                                  // style: AppStyles.textStyle(
                                  //   weight: FontWeight.w500,
                                  //   fontSize: dimen15,
                                  // ),
                                ),
                              ),

                              Divider(),

                              const SizedBox(
                                height: 20,
                              ),
                              /* Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 0),
                                child: Text(
                                  "Reviews",
                                  style: AppStyles.textStyle(
                                    weight: FontWeight.w500,
                                    fontSize: dimen15,
                                  ),
                                ),
                              ),*/

                              SizedBox(height: 10),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     controller.productDetails.value.rating![0].rating !=
                              //             null
                              //         ? Padding(
                              //             padding: const EdgeInsets.only(
                              //                 left: 15, right: 10),
                              //             child: RatingBar.builder(
                              //               initialRating: controller.productDetails
                              //                       .value.rating![0].rating
                              //                       .toDouble() ??
                              //                   0.toDouble(),
                              //               minRating: 1,
                              //               direction: Axis.horizontal,
                              //               allowHalfRating: true,
                              //               itemCount: 5,
                              //               itemSize: 15.5,
                              //               itemPadding: EdgeInsets.symmetric(
                              //                 horizontal: 2.0,
                              //               ),
                              //               itemBuilder: (context, _) => Icon(
                              //                 Icons.star,
                              //                 color: Colors.amber,
                              //                 size: 2,
                              //               ),
                              //               onRatingUpdate: (rating) {
                              //                 print(rating);
                              //               },
                              //             ),
                              //           )
                              //         : Padding(
                              //             padding: const EdgeInsets.only(
                              //                 left: 15, right: 10),
                              //             child: RatingBar.builder(
                              //               initialRating: 5,
                              //               minRating: 1,
                              //               direction: Axis.horizontal,
                              //               allowHalfRating: true,
                              //               itemCount: 0,
                              //               itemSize: 15.5,
                              //               itemPadding: EdgeInsets.symmetric(
                              //                 horizontal: 2.0,
                              //               ),
                              //               itemBuilder: (context, _) => Icon(
                              //                 Icons.star,
                              //                 color: Colors.white,
                              //                 size: 2,
                              //               ),
                              //               onRatingUpdate: (rating) {
                              //                 print(rating);
                              //               },
                              //             ),
                              //           ),
                              //     Text(
                              //       '${controller.productDetails.value.product.variants![p].rating.toString()}/5',
                              //       style: AppStyles.textStyle(
                              //         weight: FontWeight.w500,
                              //         fontSize: 14.0,
                              //       ),
                              //     )
                              //   ],
                              // ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // ListView.builder(
                                  //     shrinkWrap: true,
                                  //     physics: const BouncingScrollPhysics(),
                                  //     // scrollDirection: Axis.horizontal,
                                  //     itemCount: controller.productReviewsList.length,
                                  //     itemBuilder: (context, index) {
                                  //       return reviewList(index);
                                  //     })
                                ],
                              ),
                              SizedBox(
                                height: 100,
                              ),
                            ],
                          )),
                    )
                  : shimmerDemo(),
            ),
            Obx(
              () => controller.dataIsLoading.isFalse
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: (controller.isLoader.value)
                          ? InkWell(
                              onTap: () {
                                if (controller.addButtonStatus.isTrue) {
                                  Get.find<BaseHomeController>()
                                      .selectedIndex
                                      .value = 3;
                                  Get.find<CartController>().onInit();
                                  Get.toNamed(AppPages.baseScreen);
                                  print("jnxkzmlk==>1");
                                } else {
                                  print("jnxkzmlk==>2");
                                  controller.addToCart(
                                      title: controller.products[0].title,
                                      id: controller.products[0].id,
                                      variantId: controller
                                          .products[0].productVariants[0].id);
                                }
                              },
                              child: Container(
                                width: 95.w,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: AppColors.color7C,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      Assets.bag,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      controller.addButtonStatus.isTrue
                                          ? "go_to_cart".tr
                                          : "add_to_cart".tr,
                                      style: AppStyles.textStyle(
                                        color: AppColors.lightBackgroundColor,
                                        fontSize: 14.0,
                                        weight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ).paddingOnly(bottom: 1),
                            )
                          : Container(
                              width: 95.w,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: AppColors.color7C,
                              ),
                              child: const SpinKitThreeBounce(
                                color: Colors.white,
                                size: 30,
                              ),
                            ).paddingOnly(bottom: 1))
                  : SizedBox(),
            )
          ],
        ));
  }

// reviewList(index) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               controller.productDetailsList[index].title.toString() ??
//                   "".toString(),
//               style: AppStyles.textStyle(
//                 weight: FontWeight.w500,
//                 fontSize: dimen15,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 7, top: 5),
//               child: Text(
//                 "${controller.productReviewsList[index].rating.toString()}/5",
//                 style: AppStyles.textStyle(
//                     weight: FontWeight.normal,
//                     fontSize: 14.0,
//                     color: AppColors.gray99),
//               ),
//             ),
//           ],
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
//         child: Text(
//           controller.productReviewsList[index].review.toString(),
//           style: AppStyles.textStyle(
//               weight: FontWeight.normal,
//               fontSize: 14.0,
//               color: AppColors.gray99),
//         ),
//       ),
//       SizedBox(
//         height: 20,
//       ),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 15, right: 10),
//             child: RatingBar.builder(
//               initialRating:controller.productReviewsList[index].rating!.toDouble()??0.0,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemSize: 15.5,
//               itemPadding: EdgeInsets.symmetric(
//                 horizontal: 2.0,
//               ),
//               itemBuilder: (context, _) => Icon(
//                 Icons.star,
//                 color: Colors.black,
//                 size: 2,
//               ),
//               onRatingUpdate: (rating) {
//                 print(rating);
//               },
//             ),
//           ),
//           Text(
//             '${controller.productReviewsList[index].rating.toString()}/5',
//             style: AppStyles.textStyle(
//               weight: FontWeight.w500,
//               fontSize: 14.0,
//             ),
//           )
//         ],
//       ),
//     ],
//   );
// }

  shimmerDemo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Shimmer.fromColors(
          baseColor: ThemeService().loadThemeFromBox()
              ? AppColors.color4A
              : Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Container(
                    width: 100.w,
                    height: 40.h,
                    color: Colors.white,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  shimmerDemoTranslate() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: 100.h,
        height: 10.0,
        child: Shimmer.fromColors(
          baseColor: ThemeService().loadThemeFromBox()
              ? AppColors.color4A
              : Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 100.h,
            height: 10.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
