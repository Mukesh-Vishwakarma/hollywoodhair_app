
import 'package:get/get.dart';
import 'web_checkout_controller.dart';

class WebCheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebCheckoutController>(
          () => WebCheckoutController(),
    );
  }
}