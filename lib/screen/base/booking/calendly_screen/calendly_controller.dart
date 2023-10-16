import 'dart:async';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CalendlyController extends GetxController {
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  var isLoading = true.obs;
  var hideAppbar = true.obs;
  String currentUrl = ''; // Member variable to store the current URL

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
}
