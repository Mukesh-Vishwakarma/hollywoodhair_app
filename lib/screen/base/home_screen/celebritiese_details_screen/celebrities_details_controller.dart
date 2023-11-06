import 'dart:async';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CelebritiesDetailsController extends GetxController {
  Completer<WebViewController> controllerWeb = Completer<WebViewController>();
  InAppWebViewController? webViewController;
  var isLoading = true.obs;
  String title = '';
  var socialUrl = ''.obs;

  @override
  void onInit() {
    try {
      title = Get.arguments[0];
      socialUrl.value = Get.arguments[1];
      isLoading.value = true;
      print("sdvabnjmk==> ${socialUrl.value}");
    } catch (e) {
      isLoading.value = false;
    }
    super.onInit();
  }

  void setWebViewController(WebViewController webViewController) {
    webViewController = webViewController;
  }

  @override
  void dispose() {
    disposeWebView();
    super.dispose();
  }

  Future<void> disposeWebView() async {
    if (await controllerWeb.future
        .then((webViewController) => webViewController != null)) {
      final webViewController = await controllerWeb.future;
      webViewController.clearCache();
      webViewController
          .loadUrl('about:blank'); // Load a blank page to release resources
      controllerWeb.complete(null); // Set the controller to null
    }
  }

/*WebView(
  initialUrl: AppConstants.calendlyUlr,
  javascriptMode: JavascriptMode.unrestricted,
  onWebViewCreated:
      (WebViewController webViewController) {
    if (!controller.controllerWeb.isCompleted) {
      controller.controllerWeb
          .complete(webViewController);
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
),*/
}
