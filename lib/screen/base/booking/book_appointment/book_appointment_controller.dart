import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import '../../../../api_provider/api_provider.dart';
import '../../../../model/all_artist_model.dart';
import '../../../../model/available_slots_list_model.dart';
import '../../../../model/book_appointment_model.dart';

class BookAppointmentController extends GetxController {

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



  var nameController = TextEditingController();
  var dateTimeController = TextEditingController();
  final formBookingKey = GlobalKey<FormState>();


  var dateFocusNode = FocusNode();

  var artistName = "".obs;
  var artistId = "".obs;
  var dateTime = "".obs;
  var selectTime = "".obs;

  var name = "".obs;
  var age = "".obs;
  var gender = "".obs;
  var service = "".obs;
  var serviceId = "".obs;
  var saloonLocation = "".obs;
  var phoneNumber = "".obs;
  var saloonId = "".obs;
  var timeSlot = "".obs;
  var timeSlotId = "".obs;

  var pageLoaderService = true.obs;

  var searchArtistController = TextEditingController();
  var isArtistSearch = false.obs;
  var searchArtistText = "".obs;
  var allArtistList = <AllArtistData>[].obs;
  var searchArtistList = <AllArtistData>[].obs;
  var firstTimeScreen = true.obs;

  var availableSlotsList = <DataSlots>[].obs;

  var isLoading = true.obs;
  var isPageLoad = false.obs;

  @override
  void onInit() {
    try {
      Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
      name.value = args['name'];
      phoneNumber.value = args['phone_number'];
      age.value = args['age'];
      gender.value = args['gender'];
      service.value = args['service'];
      serviceId.value = args['serviceId'];
      saloonLocation.value = args['saloon_address'];
      saloonId.value = args['saloonId'];
      pageLoaderService.value = true;
      getArtistList();
    } catch (e) {
      print("jhskz==> $e");
    }

    super.onInit();
  }

  /// get services list
  getArtistList() {
    Future.delayed(const Duration(seconds: 1), () {
      getAllArtistList();
      firstTimeScreen.value = false;
    });
  }

  getSearchArtistList(value) {
    if (value.toString().isEmpty) {
      searchArtistList.value = [];
      isArtistSearch.value = false;
      searchArtistController.clear();
      searchArtistText.value = value;
      refresh();
    } else {
      searchArtistList.value = allArtistList
          .where((user) {
            return user.workerName
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase());
          })
          .cast<AllArtistData>()
          .toList();
      searchArtistList.refresh();
      print("sdjhsnkc==> ${searchArtistList.value[0].workerName}");
      isArtistSearch.value = true;
      update();
    }
  }

  getAllArtistList() async {
    try {
      isLoading.value = true;
      AllArtistModel allArtistModel =
          await ApiProvider.booking().getAllArtistList(saloonId.value);
      pageLoaderService.value = false;
      if (allArtistModel.result == 1) {
        allArtistList.value = allArtistModel.allArtistData!;
      }
      print("jhsdfxgcdhdA==> ${allArtistModel.msg}");
      isLoading.value = false;
    } on HttpException catch (exception) {
      print("jdfksx==> ${exception.message}");
      pageLoaderService.value = false;
      isLoading.value = false;
    } catch (exception) {
      pageLoaderService.value = false;
      isLoading.value = false;
      print("jfksdmlcxkcx==> ${exception.toString()}");
    }
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
      pageLoaderService.value = false;
      if (availableSlotsListModel.result == 1) {
        availableSlotsList.value = availableSlotsListModel.dataSlots!;
      }
      print("jhssdfwdgcdhdA==> ${availableSlotsListModel.msg}");
      isLoading.value = false;
    } on HttpException catch (exception) {
      print("jddfdffksx==> ${exception.message}");
      pageLoaderService.value = false;
      successToast("Network issue");
      isLoading.value = false;
    } catch (exception) {
      pageLoaderService.value = false;
      availableSlotsList.clear();
      print("jfksddfdmlcxkcx==> ${exception.toString()}");
      successToast("Network issue");
      isLoading.value = false;
    }
  }

  bookingFinal() async {
    var date = dateTimeController.text.trim().toString();

    if (timeSlotId.value != '') {
      try {
        isPageLoad.value = true;
        final Map<String, dynamic> requestBody = {
          // 'salon_id': saloonId.value,
          'salon_id': "1",
          'worker_id': artistId.value,
          'customer_name': name.value,
          'age': age.value,
          'email': "",
          'gender': gender.value,
          'phone': phoneNumber.value,
          'booking_date': date,
          'signature': "",
          'booking_id': "",
        };
        final List<String> services = [serviceId.value.toString()];
        requestBody['services'] = services;
        final List<String> slots = [timeSlotId.value.toString()];
        requestBody['slots'] = slots;

        print("hsdbk==> $requestBody");
        BookAppointmentModel bookAppointmentModel =
            await ApiProvider.booking().getFinalBookingSlots(requestBody);
        if (bookAppointmentModel.result == 1) {
          successToast(bookAppointmentModel.msg);
          Get.toNamed(AppPages.successfulScreen);
        }
        isPageLoad.value = false;
      } on HttpException catch (exception) {
        print("jddfdffdksx==> ${exception.message}");
        isPageLoad.value = false;
        // pageLoaderService.value = false;
      } catch (exception) {
        // pageLoaderService.value = false;
        print("jfksdddfdmlcxkcx==> ${exception.toString()}");
        isPageLoad.value = false;
      }
    } else {
      successToast("Please select available slots.");
    }
  }
}
