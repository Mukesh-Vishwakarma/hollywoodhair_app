import 'package:get/get.dart';
import 'showroom_dropdown_controller.dart';

class ShowroomDropdownBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowroomDropdownController>(
      () => ShowroomDropdownController(),
    );
  }
}
