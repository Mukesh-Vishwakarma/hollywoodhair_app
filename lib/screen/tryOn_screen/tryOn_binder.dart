import 'package:get/get.dart';
import 'package:hollywood_hair/screen/tryOn_screen/tryOn_controller.dart';

class TryOnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TryOnController>(() => TryOnController(),
    );
  }
}