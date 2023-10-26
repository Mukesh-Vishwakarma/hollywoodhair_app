
import 'package:get/get.dart';
import 'celebrities_controller.dart';

class CelebritiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CelebritiesController>(
          () => CelebritiesController(),
    );
  }
}