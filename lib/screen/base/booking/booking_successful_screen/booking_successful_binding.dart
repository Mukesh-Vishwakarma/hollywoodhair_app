import 'package:get/get.dart';

import 'booking_successful_controller.dart';

class BookingSuccessfulBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingSuccessfulController>(
          () => BookingSuccessfulController(),
    );
  }
}