import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../util/app_constants.dart';
import 'calendly_controller.dart';

class CalendlyScreen extends GetView<CalendlyController> {
  const CalendlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: AppColors.colorFF,
          titleSpacing: 0,
          title: Text(
            "booking".tr,
            style: AppStyles.textStyle(fontSize: dimen15, weight: FontWeight.w400),
          ),
          automaticallyImplyLeading: false, // Disable the default back button
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.black,), // You can customize this icon
            onPressed: () {
              // Handle the back button press, e.g., pop the current screen.
              Navigator.of(context).pop();
            },
          ),
        )
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: AppConstants.calendlyUlr,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              controller.controller.complete(webViewController);
            },
            onPageFinished: (String url) {
              controller.isLoading.value = false; // Set loading state to false when page finishes loading
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
