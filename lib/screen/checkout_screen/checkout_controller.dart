import 'dart:async';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutController extends GetxController {

  late Completer<WebViewController> controller = Completer<WebViewController>();
  var isLoading = true.obs;

  var url = "".obs;

  @override
  void onInit() {
    try {
      url.value = Get.arguments[0];
    } catch (e){
      print("sjkfdnxnjS===> $e");
    }
    super.onInit();
  }
}
