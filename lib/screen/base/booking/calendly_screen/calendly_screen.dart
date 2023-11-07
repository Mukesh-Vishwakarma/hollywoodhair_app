import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
  const CalendlyScreen({super.key});

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
                  leading: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50), // Set the same rounded border as Material
                    ),
                    onTap: () async {
                      if (controller.webViewController != null) {
                        if (await controller.webViewController!.canGoBack()) {
                          controller.webViewController!.goBack();
                        } else {
                          Get.back();
                        }
                      } else {
                        Get.back();
                      }
                      // try {
                      //   if (await controller.webViewController.future.then(
                      //       (webViewController) =>
                      //           webViewController.canGoBack())) {
                      //     controller.webViewController.future.then(
                      //       (webViewController) => webViewController.goBack(),
                      //     );
                      //   } else {
                      //     Get.back();
                      //   }
                      // } catch (e) {
                      //   Get.back();
                      // }
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
                    if (controller.webViewController != null) {
                      if (await controller.webViewController!.canGoBack()) {
                        controller.webViewController!.goBack();
                        return false; // Prevent the app from closing
                      } else {
                        return true; // Allow the app to close
                      }
                    }
                    return true; // If there is no webViewController, just allow the app to close

                    // if (await controller.webViewController.future.then(
                    //     (webViewController) => webViewController.canGoBack())) {
                    //   controller.webViewController.future.then(
                    //     (webViewController) => webViewController.goBack(),
                    //   );
                    //   return false; // Prevent the app from closing
                    // } else {
                    //   return true; // Allow the app to close
                    // }
                  },
                  child: Stack(
                    children: <Widget>[
                      InAppWebView(
                          initialUrlRequest: URLRequest(
                              url: Uri.parse(AppConstants.calendlyUlr)),
                          initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                              javaScriptEnabled: true,
                            ),
                          ),
                          onWebViewCreated: (InAppWebViewController webViewController) {
                            // if (!controller.webViewControllerNew.isCompleted) {
                              controller.webViewController = webViewController;
                            // }
                          },
                          onLoadStart:
                              (InAppWebViewController controller, Uri? url) {
                            if (url != null) {
                              print("==> $url");
                            }
                          },
                          onLoadStop: (InAppWebViewController webViewControllerNew, Uri? url) {
                            if (url != null) {
                              try {
                                controller.isLoading.value = false;
                              } catch (e) {
                                print("Error: $e");
                              }
                            }
                          }),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,  // Align the gradient from the left
                              end: Alignment.centerRight,  // To the right
                              colors: [Colors.white,AppColors.whiteTrans1, AppColors.whiteTrans],  // Your gradient colors
                            ),
                          ),
                          height: 80,
                          width: 150,
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
