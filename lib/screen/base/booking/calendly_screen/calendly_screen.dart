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
    Get.lazyPut(()=>CalendlyController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Obx(
          ()=> controller.hideAppbar.value == true ? AppBar(
            elevation: 0,
            backgroundColor: AppColors.colorFF,
            titleSpacing: 0,
            title: Text(
              "booking".tr,
              style: AppStyles.textStyle(
                  fontSize: dimen15,
                  weight: FontWeight.w400),
            ),
            automaticallyImplyLeading: false, // Disable the default back button
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                color: Colors.black,), // You can customize this icon
              onPressed: () {
                Get.back();
              },
            ),
          ): SizedBox(height: 70.0,),
        )
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              initialUrl: AppConstants.calendlyUlr,
              javascriptMode: JavascriptMode.unrestricted,
              // onProgress: (v){
              //   controller.hideAppbar.value = false;
              // },
              onWebViewCreated: (WebViewController webViewController) {
                // controller.hideAppbar.value = true;
                controller.controller.complete(webViewController);
              },
              onPageStarted: (va){
                controller.hideAppbar.value = false;
              },
              onPageFinished: (String url) {
                try {
                  controller.isLoading.value = false;// Set loading state to false when page finishes loading
                  controller.hideAppbar.value = true;
                  // Get.back();
                } catch(e){
                  print("sjdhbjhb==> $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
