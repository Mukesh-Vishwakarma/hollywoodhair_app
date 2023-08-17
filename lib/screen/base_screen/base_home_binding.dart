import 'package:get/get.dart';


import 'base_home_controller.dart';

class BaseHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseHomeController>(
          () => BaseHomeController(),
    );
  }
}
