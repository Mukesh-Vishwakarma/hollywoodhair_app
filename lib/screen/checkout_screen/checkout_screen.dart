import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../util/app_colors.dart';
import '../../util/app_style.dart';
import '../../util/assets.dart';
import '../../util/res_dimens.dart';
import 'checkout_controller.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(7.h),
              child: AppBar(
                backgroundColor: AppColors.colorFF,
                titleSpacing: 0,
                elevation: 0.5,
                title: Text(
                  "checkout".tr,
                  style: AppStyles.textStyle(
                      fontSize: 16.0, weight: FontWeight.w400),
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
                    if (await controller.controller.future.then(
                        (webViewController) => webViewController.canGoBack())) {
                      controller.controller.future.then(
                        (webViewController) => webViewController.goBack(),
                      );
                    } else {
                      Get.back();
                    }
                  },
                ),
              )),
          body: WillPopScope(
            onWillPop: () async {
              if (await controller.controller.future
                  .then((webViewController) => webViewController.canGoBack())) {
                controller.controller.future.then(
                  (webViewController) => webViewController.goBack(),
                );
                return false; // Prevent the app from closing
              } else {
                return true; // Allow the app to close
              }
            },
            child: SafeArea(
              child: Stack(
                children: <Widget>[
                  WebView(
                    initialUrl: controller.url.value,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      controller.controller.complete(webViewController);
                    },
                    onPageFinished: (String url) {
                      try {
                        controller.isLoading.value = false;
                      } catch (e) {
                        print("sjdhbjhb==> $e");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: controller.isLoading.value,
          child: loader(),
        )
      ],
    ))
    ;
  }

  loader() {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.transparentBlack,
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
