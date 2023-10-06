import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/models/src/shopify_user/addresses/addresses.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class AddressController extends GetxController {
  // var getAddress = <ShopifyUser>[].obs;

  final formLoginKey = GlobalKey<FormState>();

  // var addressTypeController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var companyController = TextEditingController();
  var cityController = TextEditingController();
  var countryController = TextEditingController();
  var address1Controller = TextEditingController();
  var address2Controller = TextEditingController();
  var phoneNumberController = TextEditingController();
  var zipCodeController = TextEditingController();
  Addresses? addresses;
  var selectAddress = "".obs;
  var customerAccessToken;

  var isPageLoad = true.obs;
  var noData = true.obs;
  var checkAddress = RxInt(-1);

  ShopifyCustomer shopifyCustomer = ShopifyCustomer.instance;
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;

  var email = "";

  // RxList<ShopifyUser> collectionList = <ShopifyUser>[
  //   ShopifyUser(
  //       title: "All",
  //       id: "ALL",
  //       products: Products(productList: [], hasNextPage: false))
  // ].obs;
  var selectedCollection = "".obs;

  @override
  void onInit() async {
    shopifyCustomer = ShopifyCustomer.instance;
    shopifyAuth = ShopifyAuth.instance;
    customerAccessToken = shopifyAuth.currentCustomerAccessToken;
    await getAllAddressApi();
    super.onInit();
  }

  //  ****** clear text field
  clearTextFiled() {
    address1Controller.text = "";
    address2Controller.text = "";
    firstNameController.text = "";
    lastNameController.text = "";
    cityController.text = "";
    countryController.text = "";
    companyController.text = "";
    zipCodeController.text = "";
    phoneNumberController.text = "";
  }

  updateAddresses({id}) async {
    try {
      isPageLoad.value = true;
      ShopifyCustomer shopifyCustomer = ShopifyCustomer.instance;
      shopifyCustomer
          .customerAddressUpdate(
            customerAccessToken: customerAccessToken,
            id: StringIDGet(id),
            zip: zipCodeController.text,
            phone: phoneNumberController.text,
            lastName: lastNameController.text,
            firstName: firstNameController.text,
            country: countryController.text,
            company: companyController.text,
            city: cityController.text,
            address2: address2Controller.text,
            address1: address1Controller.text,
          )
          .onError((error, stackTrace) => print("error $error"))
          .catchError(() {
        print("kamal");
      });
      clearTextFiled();
      await getAllAddressApi();
      isPageLoad.value = false;
      Get.back();
    } catch (error) {
      isPageLoad.value = false;
      await getAllAddressApi();
      Get.back();
      debugPrint("messgae:${await error}");
    }
  }

  deleteAddresses(id) async {
    try {
      print(id);
      ShopifyCustomer shopifyCustomer = ShopifyCustomer.instance;
      await shopifyCustomer.customerAddressDelete(
          customerAccessToken: customerAccessToken, addressId: StringIDGet(id));
      addresses!.addressList.removeWhere((element) => element.id == id);
      await getAllAddressApi();
    } catch (error) {
      await getAllAddressApi();
      debugPrint("messgae:$error");
    }
  }

  createAddresses() async {
    try {
      isPageLoad.value = true;
      ShopifyCustomer shopifyCustomer = ShopifyCustomer.instance;
      shopifyCustomer.customerAddressCreate(
          zip: zipCodeController.text,
          phone: phoneNumberController.text,
          lastName: lastNameController.text,
          firstName: firstNameController.text,
          country: countryController.text,
          company: companyController.text,
          city: cityController.text,
          address2: address2Controller.text,
          address1: address1Controller.text,
          customerAccessToken: await customerAccessToken);
      clearTextFiled();
      await getAllAddressApi();
      Get.back();
      isPageLoad.value = false;
      // shopifyCustomer.customerAddressCreate(
      //     address1: '71 ST. NICHOLAS DRIVE12',
      //     // Replace with the address
      //     address2: 'Apt 4B',
      //     // Replace with address line 2 (optional)
      //     company: 'Company Inc',
      //     // Replace with the company (optional)
      //     city: 'FAIRBANKS',
      //     // Replace with the city
      //     country: 'Poland',
      //     // Replace with the country
      //     firstName: 'John',
      //     // Replace with the first name
      //     lastName: 'Doe',
      //     // Replace with the last name
      //     phone: '123-456-7890',
      //     // Replace with the phone number
      //     province: 'State',
      //     // Replace with the province or state
      //     zip: '99504',
      //     customerAccessToken: await customerAccessToken);
    } catch (error) {
      isPageLoad.value = false;
      await getAllAddressApi();
      Get.back();
      debugPrint("messgae:$error");
    }
  }

  getAllAddressApi() async {
    try {
      isPageLoad.value = true;
      noData.value = true;
      ShopifyUser? shopifyUser = await shopifyAuth.currentUser();
      addresses = Addresses(addressList: []);
      addresses = shopifyUser!.address;
      email = shopifyUser!.email.toString();
      noData.value = false;
      isPageLoad.value = false;
    } on HttpException catch (exception) {
      // progressDialog.dismiss();
      print(exception.message);
      isPageLoad.value = false;
      // failedToast(exception.message);
    } catch (exception) {
      // progressDialog.dismiss();
      print(exception.toString());
      isPageLoad.value = false;
      // failedToast(exception.toString());
    }
  }

  StringIDGet(input) {
    try {
      RegExp regExp = RegExp(r'(\d+)');
      Match match = regExp.firstMatch(input)!;

      // Check if a match was found
      if (match != null) {
        String numericPortion = match.group(0).toString();
        return numericPortion;
      }
    } catch (e) {
      return "";
    }
  }
}
