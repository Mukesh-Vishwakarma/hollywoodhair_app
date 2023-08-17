import 'package:get/get.dart';
import 'package:hollywood_hair/screen/cart_screen/cart_controller.dart';
import 'package:hollywood_hair/screen/home_screen/home_controller.dart';




class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(
          () =>CartController(),
    );
  }
}
