import 'package:get/get.dart';

import '../../../../util/route/app_pages.dart';

class BookingSuccessfulController extends GetxController {

  var textHeading = 'Appointment Confirmed!'.obs;
  var textDescription = 'Your appointment is confirmed for 1 Aug 2023, 9:30 am. Get ready to be pampered and look your best!'.obs;

  @override
  void onInit() {
    super.onInit();
    getBackScreen();
  }

  getBackScreen() async {
    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
      Get.back();
      Get.offNamed(AppPages.myAppointmentScreen);
    });
  }

}