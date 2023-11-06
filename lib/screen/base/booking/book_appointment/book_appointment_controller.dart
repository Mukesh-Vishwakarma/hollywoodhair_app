import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../api_provider/api_provider.dart';
import '../../../../model/all_artist_model.dart';
import '../../../../model/available_slots_list_model.dart';

class BookAppointmentController extends GetxController {
  var nameController = TextEditingController();
  var dateTimeController = TextEditingController();

  var dateFocusNode = FocusNode();

  var timeList = [
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 AM',
    '12:30 AM',
    '01:00 AM',
    '01:30 AM',
    '02:00 AM'
  ].obs;

  var artistName = "".obs;
  var dateTime = "".obs;
  var selectTime = "".obs;

  var name = "".obs;
  var age = "".obs;
  var gender = "".obs;
  var service = "".obs;
  var saloonLocation = "".obs;
  var phoneNumber = "".obs;
  var saloonId = "1".obs;
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

  @override
  void onInit() {
    try {
      Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
      name.value = args['name'];
      phoneNumber.value = args['phone_number'];
      age.value = args['age'];
      gender.value = args['gender'];
      service.value = args['service'];
      saloonLocation.value = args['saloon_address'];

      getArtistList();
    } catch (e) {
      print("jhskz==> $e");
    }

    super.onInit();
  }

  /// get services list
  getArtistList() {
    Future.delayed(const Duration(seconds: 1), () {
      getAllServicesList();
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

  getAllServicesList() async {
    try {
      var saloonId = "1";
      AllArtistModel allArtistModel =
          await ApiProvider.booking().getAllArtistList(saloonId);
      pageLoaderService.value = false;
      if (allArtistModel.result == 1) {
        allArtistList.value = allArtistModel.allArtistData!;
      }
      print("jhsdfxgcdhdA==> ${allArtistModel.msg}");
    } on HttpException catch (exception) {
      print("jdfksx==> ${exception.message}");
      pageLoaderService.value = false;
    } catch (exception) {
      pageLoaderService.value = false;
      print("jfksdmlcxkcx==> ${exception.toString()}");
    }
  }

  getAvailableSlotsList(saloonId, date) async {
    try {
      final Map<String, dynamic> requestBody = {
        'salon_id': saloonId,
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
    } on HttpException catch (exception) {
      print("jddfdffksx==> ${exception.message}");
      pageLoaderService.value = false;
    } catch (exception) {
      pageLoaderService.value = false;
      print("jfksddfdmlcxkcx==> ${exception.toString()}");
    }
  }
}
