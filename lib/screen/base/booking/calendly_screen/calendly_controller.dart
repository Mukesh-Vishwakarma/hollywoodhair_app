import 'dart:async';

import 'package:get/get.dart';
import 'package:hollywood_hair/util/progress_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CalendlyController extends GetxController {
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  var isLoading = true.obs;

  @override
  void onInit() {
    try {
    } catch (e){
      print("sjkfdnxnjS===> $e");
    }
    super.onInit();
  }
}
