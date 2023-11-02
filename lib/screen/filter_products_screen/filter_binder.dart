import 'package:get/get.dart';
import 'filter_controller.dart';

class FilterProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterProductController>(
      () => FilterProductController(),
    );
  }
}
