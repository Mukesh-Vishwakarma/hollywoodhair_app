import 'dart:async';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CalendlyController extends GetxController {
  Completer<WebViewController> controllerWeb = Completer<WebViewController>();
  InAppWebViewController? webViewController;
  var isLoading = true.obs;
  var hideAppbar = true.obs;
  String currentUrl = ''; // Member variable to store the current URL
  // WebViewController? webViewController; // Add a member variable to store the WebViewController

  @override
  void onInit() {
    try {
      isLoading.value = true;
      print("sjkfdnxnjS===> ");
    } catch (e) {
      print("sjkfdnxnjS===> $e");
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
    if (await controllerWeb.future.then((webViewController) => webViewController != null)) {
      final webViewController = await controllerWeb.future;
      webViewController.clearCache();
      webViewController.loadUrl('about:blank'); // Load a blank page to release resources
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
