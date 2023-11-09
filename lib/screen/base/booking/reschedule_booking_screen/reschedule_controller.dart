import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../api_provider/api_provider.dart';
import '../../../../model/available_slots_list_model.dart';
import '../../../../model/book_appointment_model.dart';
import '../../../../util/common_function.dart';

class RescheduleController extends GetxController {
  static const int _orangePrimaryValue = 0xffEBADB7;
  MaterialColor orange = const MaterialColor(
    _orangePrimaryValue,
    <int, Color>{
      50: Color(0xffEBADB7),
      100: Color(0xffEBADB7),
      200: Color(0xffEBADB7),
      300: Color(0xffEBADB7),
      400: Color(0xffEBADB7),
      500: Color(_orangePrimaryValue),
      600: Color(0xffEBADB7),
      700: Color(0xffEBADB7),
      800: Color(0xffEBADB7),
      900: Color(0xffEBADB7),
    },
  );

  var dateTimeController = TextEditingController();
  final formBookingKey = GlobalKey<FormState>();
  var dateFocusNode = FocusNode();
  var dateTime = "".obs;
  var timeSlot = "".obs;
  var timeSlotId = "".obs;

  var availableSlotsList = <DataSlots>[].obs;

  var isLoading = false.obs;
  var isPageLoad = false.obs;

  var saloonId = "".obs;
  var bookingId = "".obs;

  @override
  void onInit() {
    try {
      Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
      saloonId.value = args['saloon_id'];
      bookingId.value = args['booking_id'];
    } catch (e) {
      print("jhskz==> $e");
    }
    super.onInit();
  }

  getAvailableSlotsList(date) async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> requestBody = {
        'salon_id': saloonId.value,
        'date': date
      };
      print("jsdkz==> $requestBody");
      AvailableSlotsListModel availableSlotsListModel =
          await ApiProvider.booking().getAvailableSlotsList(requestBody);
      if (availableSlotsListModel.result == 1) {
        availableSlotsList.value = availableSlotsListModel.dataSlots!;
      }
      print("jhdhdA==> ${availableSlotsListModel.msg}");
      isLoading.value = false;
    } on HttpException catch (exception) {
      print("jddfdfsx==> ${exception.message}");
      successToast("Some issue found");
      isLoading.value = false;
    } catch (exception) {
      availableSlotsList.clear();
      print("jfksdcxkcx==> ${exception.toString()}");
      successToast("Some issue found");
      isLoading.value = false;
    }
  }

  getRescheduleSlots(date) async {
    if (timeSlotId.value != '') {
      try {
        isLoading.value = true;
        final Map<String, dynamic> requestBody = {
          'booking_id': bookingId.value,
          'salon_id': saloonId.value,
          'date': date,
        };
        final List<String> slots = [timeSlotId.value.toString()];
        requestBody['slots'] = slots;

        print("jsdkz==> $requestBody");
        BookAppointmentModel bookAppointmentModel =
            await ApiProvider.booking().getRescheduleSlotsAPI(requestBody);
        if (bookAppointmentModel.result == 1) {
          Get.back(result: 'Successful');
        }
        print("jhssdhdA==> ${bookAppointmentModel.msg}");
        isLoading.value = false;
      } on HttpException catch (exception) {
        print("jddsdksx==> ${exception.message}");
        successToast("Network issue");
        isLoading.value = false;
      } catch (exception) {
        print("jfklcxkcx==> ${exception.toString()}");
        successToast("Network issue");
        isLoading.value = false;
      }
    } else {
      successToast("Please select available slots.");
    }
  }
}
