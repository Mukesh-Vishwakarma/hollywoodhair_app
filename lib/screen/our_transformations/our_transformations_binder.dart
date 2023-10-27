import 'package:get/get.dart';
import 'our_transformations_controller.dart';

class OurTransformationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OurTransformationsController>(
      () => OurTransformationsController(),
    );
  }
}
