import 'dart:async';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebCheckoutController extends GetxController {
  late Completer<WebViewController> controller = Completer<WebViewController>();
  var isLoading = true.obs;

  var url = "".obs;
  var successfulButtonStatus = false.obs;
  var margin = 0.0.obs;
  var backResponse = "".obs;

  @override
  void onInit() {
    try {
      url.value = Get.arguments[0];
      print("sjkfdnxnjS===>${url.value}");
    } catch (e) {
      print("sjkfdnxnjS===> $e");
    }
    super.onInit();
  }

  Future<void> delayFunction() async {
    await Future.delayed(const Duration(seconds: 4));
    margin.value = 60.0;
    successfulButtonStatus.value = true;
    backResponse.value = "successful";
  }
}
