import 'package:get/get.dart';
import 'package:hollywood_hair/screen/all_products/all_product_controller.dart';

class OurSalonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllProductController>(
      () => AllProductController(),
    );
  }
}
