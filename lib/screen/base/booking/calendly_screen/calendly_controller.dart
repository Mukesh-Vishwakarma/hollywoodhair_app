import 'dart:async';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CalendlyController extends GetxController {
  final Completer<WebViewController> controller = Completer<WebViewController>();
  var isLoading = true.obs;
  var hideAppbar = true.obs;
  String currentUrl = ''; // Member variable to store the current URL
  WebViewController? _webViewController; // Add a member variable to store the WebViewController

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

  // Define a method to set the WebViewController
  void setWebViewController(WebViewController webViewController) {
    _webViewController = webViewController;
  }

  // // Define a method to dispose of the WebView
  // void disposeWebView() {
  //   if (_webViewController != null) {
  //     _webViewController!.clearCache();
  //     // Other cleanup operations as needed
  //   }
  // }

  @override
  void dispose() {
    disposeWebView();
    super.dispose();
  }

  Future<void> disposeWebView() async {
    if (await controller.future.then((webViewController) => webViewController != null)) {
      final webViewController = await controller.future;
      webViewController.clearCache();
      webViewController.loadUrl('about:blank'); // Load a blank page to release resources
      controller.complete(null); // Set the controller to null
    }
  }
}
