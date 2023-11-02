import 'package:get/get.dart';
import 'our_celebrities_controller.dart';

class CelebritiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CelebritiesController>(
      () => CelebritiesController(),
    );
  }
}
