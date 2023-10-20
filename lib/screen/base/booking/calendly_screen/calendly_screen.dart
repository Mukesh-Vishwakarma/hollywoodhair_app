import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/assets.dart';
import 'calendly_controller.dart';

class CalendlyScreen extends GetView<CalendlyController> {




  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(7.h),
                child: AppBar(
                  titleSpacing: 0,
                  elevation: 0.4,
                  backgroundColor: AppColors.colorFF,
                  leading: GestureDetector(
                    onTap: () async {
                      try {
                        if (await controller.controller.future.then(
                                (webViewController) =>
                                webViewController.canGoBack())) {
                          controller.controller.future.then(
                                (webViewController) =>
                                webViewController.goBack(),
                          );
                        } else {
                          Get.back();
                        }
                      } catch (e){
                        Get.back();
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.black,
                    ),
                  ),
                  title: Text(
                    "book_appointment".tr,
                    style: AppStyles.textStyle(
                      fontSize: 16.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                  automaticallyImplyLeading: false,
                ),
              ),
              body: SafeArea(
                child: WillPopScope(
                  onWillPop: () async {
                    if (await controller.controller.future.then(
                        (webViewController) => webViewController.canGoBack())) {
                      controller.controller.future.then(
                        (webViewController) => webViewController.goBack(),
                      );
                      return false; // Prevent the app from closing
                    } else {
                      return true; // Allow the app to close
                    }
                  },
                  child: Stack(
                    children: <Widget>[
                      WebView(
                        initialUrl: AppConstants.calendlyUlr,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          if (!controller.controller.isCompleted) {
                            controller.controller.complete(webViewController);
                          }
                        },
                        onPageStarted: (String url) {
                          print("jshbzxkjz==> $url");
                        },
                        onPageFinished: (String url) {
                          try {
                            controller.isLoading.value = false;
                          } catch (e) {
                            print("sjdhbjhb==> $e");
                          }
                        },
                      ),

                      InkWell(
                        onTap: (){},
                        child: Container(
                          color: Colors.white,
                          height: 80,
                          width: 55,
                        ),
                      )
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
        ));
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
