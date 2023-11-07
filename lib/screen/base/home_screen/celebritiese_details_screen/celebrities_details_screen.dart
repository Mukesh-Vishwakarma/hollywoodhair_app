import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../util/common_function.dart';
import 'celebrities_details_controller.dart';

class CelebritiesDetailsScreen extends GetView<CelebritiesDetailsController> {
  const CelebritiesDetailsScreen({super.key});

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
                          Get.back(result: "backPress");
                        }
                      } else {
                        Get.back(result: "backPress");
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.black,
                    ),
                  ),
                  title: Text(
                    controller.title,
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
                        // Send a result before allowing the app to close
                        Get.back(result: "backPress");
                        return true; // Allow the app to close
                      }
                    }
                    return true; // If there is no webViewController, just allow the app to close
                  },
                  child: Stack(
                    children: <Widget>[
                      Obx(()=>InAppWebView(
                            initialUrlRequest: URLRequest(
                                url: Uri.parse(controller.socialUrl.value)),
                            initialOptions: InAppWebViewGroupOptions(
                              crossPlatform: InAppWebViewOptions(
                                javaScriptEnabled: true,
                              ),
                            ),
                            onWebViewCreated:
                                (InAppWebViewController webViewController) {
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
                            onLoadStop:
                                (InAppWebViewController webViewControllerNew,
                                    Uri? url) {
                              if (url != null) {
                                try {
                                  controller.isLoading.value = false;
                                } catch (e) {
                                  print("Error: $e");
                                }
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: controller.isLoading.value,
              child: Container(
                color: AppColors.transparentBlack,
                child: const SpinKitFadingCircle(
                  color: Colors.white,
                  size: 70.0,
                ).marginOnly(top: 70),
              ),
            )
          ],
        ));
  }
}
