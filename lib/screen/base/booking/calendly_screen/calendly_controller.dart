import 'dart:async';

import 'package:get/get.dart';
import 'package:hollywood_hair/util/progress_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CalendlyController extends GetxController {
  final Completer<WebViewController> controller = Completer<WebViewController>();
  var isLoading = true.obs;
  var hideAppbar = true.obs;





  ProgressDialog progressDialog = ProgressDialog();

  @override
  void onInit() {
    hideAppbar.value = false;
    try {
      progressDialog.show();
    } catch (e){
      print("sjkfdnxnjS===> $e");
    }
    super.onInit();
  }
}
