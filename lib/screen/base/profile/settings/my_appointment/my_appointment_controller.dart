import 'dart:io';

import 'package:get/get.dart';
import 'package:hollywood_hair/util/common_function.dart';

import '../../../../../api_provider/api_provider.dart';
import '../../../../../model/book_appointment_model.dart';
import '../../../../../model/my_all_book_appointment_model.dart';

class MyAppointmentController extends GetxController {

  var pageLoaderService = true.obs;
  var dataMyAllBooking = <DataMyAllBooking>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    pageLoaderService.value = true;
    getAllServicesList();
    super.onInit();
  }

  getAllServicesList() async {
    try {
      var status = "";
      MyAllBookAppointmentModel myAllBookAppointmentModel = await ApiProvider.booking().getMyAllSlotsList(status);
      pageLoaderService.value = false;
      if (myAllBookAppointmentModel.result == 1) {
        dataMyAllBooking.value = myAllBookAppointmentModel.dataMyAllBooking!;
        print("xbnzm==> ${dataMyAllBooking.length}");
      }
      print("jhsdfxgcdhdA==> ${myAllBookAppointmentModel.msg}");
    } on HttpException catch (exception) {
      print(exception.message);
      pageLoaderService.value = false;
    } catch (exception) {
      pageLoaderService.value = false;
      print("sadafgxhzBJNK==> ${exception.toString()}");
    }
  }

  getCancelBooking(bookingId) async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> requestBody = {
        'booking_id': bookingId,
        'booking_status': 'cancelled',
      };
      BookAppointmentModel bookAppointmentModel = await ApiProvider.booking().getCancelBooking(requestBody);
      if (bookAppointmentModel.result == 1) {
        print("xbnzm==> ${dataMyAllBooking.length}");
        successToast("${bookAppointmentModel.msg}");
        getAllServicesList();
      }
      isLoading.value = false;
      print("jhsdfxgcdhdA==> ${bookAppointmentModel.msg}");
    } on HttpException catch (exception) {
      print(exception.message);
      isLoading.value = false;
    } catch (exception) {
      print("sadafgxhzBJNK==> ${exception.toString()}");
      isLoading.value = false;
    }
  }




}