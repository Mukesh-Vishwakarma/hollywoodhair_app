import 'package:get/get.dart';
import 'package:hollywood_hair/screen/home_screen/home_controller.dart';




class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () =>HomeController(),
    );
  }
}
