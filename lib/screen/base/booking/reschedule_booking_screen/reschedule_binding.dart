import 'package:get/get.dart';

import 'reschedule_controller.dart';

class RescheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RescheduleController>(
          () => RescheduleController(),
    );
  }
}