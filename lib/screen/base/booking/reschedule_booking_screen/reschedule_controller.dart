
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';

import '../../../../api_provider/api_provider.dart';
import '../../../../model/all_artist_model.dart';
import '../../../../model/available_slots_list_model.dart';
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

    getBackScreen();
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


  getBackScreen() async {
    // Future.delayed(const Duration(seconds: 2), () {
    //   Get.back();
    //   Get.back();
    //   Get.offNamed(AppPages.myAppointmentScreen);
    // });
  }
}
