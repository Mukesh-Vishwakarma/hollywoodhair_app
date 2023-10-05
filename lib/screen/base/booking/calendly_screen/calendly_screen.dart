import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:lottie/lottie.dart';
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
