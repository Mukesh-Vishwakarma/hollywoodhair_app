import 'package:get/get.dart';

import 'our_salons_controller.dart';

class OurSalonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OurSalonsController>(
      () => OurSalonsController(),
    );
  }
}
