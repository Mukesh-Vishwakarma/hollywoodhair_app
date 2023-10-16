import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../util/app_colors.dart';
import '../../util/app_style.dart';
import '../../util/assets.dart';
import 'web_checkout_controller.dart';

class WebCheckoutScreen extends GetView<WebCheckoutController> {
  const WebCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(7.h),
              child: AppBar(
                backgroundColor: AppColors.colorFF,
                titleSpacing: 0,
                elevation: 0.5,
                title: Text(
                  "checkout".tr,
                  style: AppStyles.textStyle(
                      fontSize: 18.0, weight: FontWeight.w400),
                ),
                automaticallyImplyLeading: false,
                // Disable the default back button
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  // You can customize this icon
                  onPressed: () async {
                    if (!controller.successfulButtonStatus.value) {
                      if (await controller.controller.future.then(
                          (webViewController) =>
                              webViewController.canGoBack())) {
                        controller.controller.future.then(
                          (webViewController) => webViewController.goBack(),
                        );
                      } else {
                        Get.back(result: controller.backResponse);
                        Get.lazyPut<WebCheckoutController>(
                          () => WebCheckoutController(),
                        );
                      }
                    } else {
                      Get.back(result: controller.backResponse);
                    }
                  },
                ),
              )),
          body: WillPopScope(
            onWillPop: () async {
              if (!controller.successfulButtonStatus.value) {
                if (await controller.controller.future.then(
                    (webViewController) => webViewController.canGoBack())) {
                  controller.controller.future.then(
                    (webViewController) => webViewController.goBack(),
                  );
                  return false; // Prevent the app from closing
                } else {
                  Get.back(result: controller.backResponse);
                  return true; // Allow the app to close
                }
              } else {
                Get.back(result: controller.backResponse);
                return true;
              }
            },
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: controller.margin.value),
                  child: WebView(
                    initialUrl: controller.url.value,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      controller.controller.complete(webViewController);
                    },
                    onPageStarted: (String url) {
                      // Check if the URL contains the desired string
                      print("jshbzxkjz==> $url");

                      var successful = url.split('/').last;
                      if (successful == "thank_you") {
                        controller.delayFunction();
                      }
                    },
                    onPageFinished: (String url) {
                      try {
                        controller.isLoading.value = false;
                      } catch (e) {
                        print("sjdhbjhb==> $e");
                      }
                    },
                    navigationDelegate: (NavigationRequest request) {
                      // Handle the URL click here
                      // You can inspect the request.url and decide what to do
                      print("User clicked on URL: ${request.url}");

                      // If you want the URL to load in the WebView, return a NavigationDecision.navigate:
                      return NavigationDecision.navigate;

                      // If you want to prevent the URL from loading in the WebView, you can return NavigationDecision.prevent:
                      // return NavigationDecision.prevent;
                    },
                  ),
                ),
                Visibility(
                  visible: controller.successfulButtonStatus.value,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () async {
                        Get.back(result: controller.backResponse);
                      },
                      child: Container(
                        width: 70.w,
                        height: 52,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColors.primaryColor, width: 1.0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 14),
                        child: Center(
                          child: Text(
                            'done'.tr,
                            style: AppStyles.textStyle(
                                weight: FontWeight.w500,
                                fontSize: 16.0,
                                color: AppColors.lightBackgroundColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.isLoading.value,
                  child: loader(),
                ),
              ],
            ),
          ),
        ));
  }

  loader() {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
        ),
        Center(
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Lottie.asset(Assets.videoProgressbarBarLoader,
              height: 150, width: 150),
        )
      ],
    );
  }
}
