import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../api_provider/api_provider.dart';
import '../../../../model/all_saloon_list_model.dart';
import '../../../../model/all_services_model.dart';

class BookingFormController extends GetxController {
  final formLoginKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var ageController = TextEditingController();
  var genderController = TextEditingController(text: "Female");
  var saloonLocationController = TextEditingController();
  var serviceController = TextEditingController();

  var age = "".obs;
  var name = "".obs;
  var serviceId = "".obs;
  var saloonLocationId = "".obs;
  var phoneNumber = "".obs;

  var searchSaloonController = TextEditingController();
  var isSearch = false.obs;
  var searchText = "".obs;
  var firstTimeScreen = true.obs;

  var searchSaloonList = <SaloonData>[].obs;
  var allSaloonList = <SaloonData>[].obs;
  var pageLoaderSalon = true.obs;

  var searchServiceController = TextEditingController();
  var isServiceSearch = false.obs;
  var searchServiceText = "".obs;
  var searchServiceList = <DataServices>[].obs;
  var allServiceList = <DataServices>[].obs;
  var pageLoaderService = true.obs;

  var selectedItem = 'Select'.obs;
  var genderList = ['Male', 'Female'].obs;
  var gender = "".obs;
  var checkGender = false.obs;

  // var isGender = ''.obs;

  var isLoading = true.obs;
  var isSaloonDataStatus = true.obs;
  var isServiceDataStatus = true.obs;

  @override
  void onInit() {
    pageLoaderService.value = true;
    getSaloonList();
    getServicesList();
    super.onInit();
  }

  /// getSaloon list
  getSaloonList() {
    Future.delayed(const Duration(seconds: 1), () {
      getAllSaloonList();
      firstTimeScreen.value = false;
    });
  }

  getSearchSaloonList(value) {
    if (value.toString().isEmpty) {
      searchSaloonList.value = [];
      isSearch.value = false;
      searchSaloonController.clear();
      searchText.value = value;
      refresh();
    } else {
      searchSaloonList.value = allSaloonList
          .where((user) {
            return user.salonAddress
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase());
          })
          .cast<SaloonData>()
          .toList();
      searchSaloonList.refresh();
      print("sdjhsnkc==> ${searchSaloonList.value}");
      isSearch.value = true;
      update();
    }
  }

  getAllSaloonList() async {
    try {
      AllSaloonListModel allSaloonListModel =
          await ApiProvider.base().getAllSaloonList();
      if (allSaloonListModel.result == 1) {
        allSaloonList.value = allSaloonListModel.saloonData!;
      }
      print("jhsdA==> ${allSaloonListModel.msg}");
      pageLoaderSalon.value = false;
      isSaloonDataStatus.value = false;
      isDataLoaded();
    } on HttpException catch (exception) {
      print(exception.message);
      isSaloonDataStatus.value = false;
      isDataLoaded();
    } catch (exception) {
      pageLoaderSalon.value = false;
      isSaloonDataStatus.value = false;
      isDataLoaded();
      print(exception.toString());
    }
  }

  /// get services list
  getServicesList() {
    Future.delayed(const Duration(seconds: 1), () {
      getAllServicesList();
      firstTimeScreen.value = false;
    });
  }

  getSearchServicesList(value) {
    if (value.toString().isEmpty) {
      searchServiceList.value = [];
      isServiceSearch.value = false;
      searchServiceController.clear();
      searchServiceText.value = value;
      refresh();
    } else {
      searchServiceList.value = allServiceList
          .where((user) {
            return user.serviceName
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase());
          })
          .cast<DataServices>()
          .toList();
      searchServiceList.refresh();
      print("sdjhsnkc==> ${searchServiceList.value[0].serviceName}");
      isServiceSearch.value = true;
      update();
    }
  }

  getAllServicesList() async {
    try {
      var lan = "en";
      AllServicesModel allServicesModel =
          await ApiProvider.booking().getAllServicesList(lan);
      pageLoaderService.value = false;
      if (allServicesModel.result == 1) {
        allServiceList.value = allServicesModel.dataServices!;
      }
      print("jhsdfxgcdhdA==> ${allServicesModel.msg}");
      isServiceDataStatus.value = false;
      isDataLoaded();
    } on HttpException catch (exception) {
      print(exception.message);
      pageLoaderService.value = false;
      isServiceDataStatus.value = false;
      isDataLoaded();
    } catch (exception) {
      pageLoaderService.value = false;
      isServiceDataStatus.value = false;
      isDataLoaded();
      print(exception.toString());
    }
  }

  isDataLoaded() {
    if (!isSaloonDataStatus.value && !isServiceDataStatus.value) {
      isLoading.value = false;
    }
  }
}
