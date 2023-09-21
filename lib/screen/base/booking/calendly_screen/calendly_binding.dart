
import 'package:get/get.dart';
import 'calendly_controller.dart';

class CalendlyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendlyController>(
          () => CalendlyController(),
    );
  }
}