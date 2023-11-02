
import 'package:get/get.dart';
import 'celebrities_details_controller.dart';

class CelebritiesDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CelebritiesDetailsController>(
          () => CelebritiesDetailsController(),
    );
  }
}