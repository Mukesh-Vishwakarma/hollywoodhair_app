import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:hollywood_hair/util/progress_dialog.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/models/src/shopify_user/addresses/addresses.dart';
import 'package:shopify_flutter/shopify/shopify.dart';
import '../../../../api_provider/api_provider.dart';
import '../../../../model/shopify_model/get_address_model.dart';
import '../../../../model/shopify_model/update_address_model.dart';
import '../../../../util/app_colors.dart';

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
  var defaultAddress = true;
  Addresses? addresses;

  // List<AddressesList> addressesList = <AddressesList>[].obs;
  var addressesListNew = GetAddressModel().obs;
  var selectAddress = "".obs;
  var customerAccessToken;

  var isPageLoad = true.obs;
  var noData = true.obs;
  var checkAddress = RxInt(-1);

  ShopifyCustomer shopifyCustomer = ShopifyCustomer.instance;
  var email = "";
  var selectedCollection = "".obs;

  var addNewAddressLoaderStatus = false.obs;

  @override
  void onInit() async {
    shopifyCustomer = ShopifyCustomer.instance;
    ShopifyAuth shopifyAuth = ShopifyAuth.instance;
    customerAccessToken = shopifyAuth.currentCustomerAccessToken;
    // await getAllAddressApi();
    await getUserAddress();
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
    print("sjdghSJKA==> $id");
    try {
      isPageLoad.value = true;
      ShopifyCustomer shopifyCustomer = ShopifyCustomer.instance;
      shopifyCustomer
          .customerAddressUpdate(
            customerAccessToken: await customerAccessToken,
            id: id,
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
      // await getAllAddressApi();
      isPageLoad.value = false;
      Get.back();
    } catch (error) {
      isPageLoad.value = false;
      // await getAllAddressApi();
      Get.back();
      debugPrint("messgae:${await error}");
    }
  }

  createAddresses() async {
    try {
      isPageLoad.value = true;
      addNewAddressLoaderStatus.value = true;
      ShopifyCustomer shopifyCustomer = ShopifyCustomer.instance;

      print("csavhbjxknZ====>  ");
      final creteAddressResult = await shopifyCustomer.customerAddressCreate(
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

      print("hsjbxzkNML<==> $creteAddressResult");

      GetStorage().write(AppConstants.sippingAddress, true);
      GetStorage().write(AppConstants.companyName, companyController.text);
      GetStorage().write(AppConstants.customerAddressName, firstNameController.text);
      GetStorage().write(AppConstants.mobileNo, phoneNumberController.text);
      GetStorage().write(AppConstants.city, cityController.text);
      GetStorage().write(AppConstants.country, companyController.text);
      GetStorage().write(AppConstants.postelCode, zipCodeController.text);
      GetStorage().write(AppConstants.address1, address1Controller.text);
      GetStorage().write(AppConstants.address2, address2Controller.text);
      GetStorage().write(AppConstants.firstName, firstNameController.text);
      GetStorage().write(AppConstants.lastName, lastNameController.text);
      GetStorage().write(AppConstants.addressId, "default");

      clearTextFiled();
      getUserAddress();
      Get.back();
      isPageLoad.value = false;
      addNewAddressLoaderStatus.value = false;
    } catch (error) {
      isPageLoad.value = false;
      addNewAddressLoaderStatus.value = false;
      defaultToast("Please check country or zip.", "Invalid address",
          AppColors.primaryColorDark);
      // Get.back();
      debugPrint("messgae:$error");
    }
  }

  getUserAddress() async {
    try {
      final input = await GetStorage().read(AppConstants.userId);
      final customerId = input.split('/').last;
      GetAddressModel getAddressModel =
          await ApiProvider.shopify().getAddressShopify(customerId: customerId);
      print(await ShopifyAuth.instance.currentCustomerAccessToken);
      print(" vgfjsnzxvgfvcg");
      addresses = Addresses(addressList: []);
      // addressesList = getAddressModel.addresses!;
      addressesListNew.value = getAddressModel;
      print(" vgfvgfvcg ${getAddressModel.addresses![0].id.toString()}");
      // email = getAddressModel.addresses![0].phone.toString();
      noData.value = false;
      isPageLoad.value = false;
    } on HttpException catch (exception) {
      print(exception.message);
      isPageLoad.value = false;
    } catch (exception) {
      print(exception.toString());
      isPageLoad.value = false;
    }
  }

  deleteCustomerAddress(addressId) async {
    ProgressDialog progressIndicator = ProgressDialog();
    try {
      progressIndicator.show();

      final input = await GetStorage().read(AppConstants.userId);
      final customerId = input.split('/').last;
      await ApiProvider.shopify()
          .deleteAddressShopify(customerId: customerId, addressId: addressId);
      getUserAddress();
      noData.value = false;
      isPageLoad.value = false;
      progressIndicator.dismiss();
    } on HttpException catch (exception) {
      print("kjsdbxcbh1==> ${exception.message}");
      isPageLoad.value = false;
      progressIndicator.dismiss();
    } catch (exception) {
      print("kjsdbxcbh2==> ${exception.toString()}");
      successToast("Cannot delete the customer’s default address");
      isPageLoad.value = false;
      progressIndicator.dismiss();
    }
  }

  getUpdateApi(addressID) async {
    try {
      addNewAddressLoaderStatus.value = true;
      final input = await GetStorage().read(AppConstants.userId);
      final customerId = input.split('/').last;

      print("sjbZNbweadfs===> ");
      var data = json.encode({
        "address": {
          "id": addressID,
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "address1": address1Controller.text,
          "address2": address2Controller.text,
          "city": cityController.text,
          "company": companyController.text,
          "country": countryController.text,
          "zip": zipCodeController.text,
          "phone": phoneNumberController.text,
          "default": defaultAddress
        }
      });

      var headers = {
        'Content-Type': 'application/json',
        'X-Shopify-Access-Token': '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',
      };

      var dio = Dio();
      var response = await dio.request(
        'https://a02f54.myshopify.com/admin/api/2021-07/customers/$customerId/addresses/$addressID.json',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        addNewAddressLoaderStatus.value = false;
        getUserAddress();
        Get.back();
      } else {
        print(response.statusMessage);
        addNewAddressLoaderStatus.value = false;
        getUserAddress();
      }
    } on HttpException catch (exception) {
      addNewAddressLoaderStatus.value = false;
      getUserAddress();
      print(exception.message);
    } catch (exception) {
      print(exception.toString());
      addNewAddressLoaderStatus.value = false;
      getUserAddress();
    }
  }

  ///  This functions is not using
  deleteAddresses(id) async {
    try {
      print(id);
      ShopifyCustomer shopifyCustomer = ShopifyCustomer.instance;
      shopifyCustomer.customerAddressDelete(
          customerAccessToken: await customerAccessToken, addressId: id);
      // addresses!.addressList.removeWhere((element) => element.id == id);
      // await getAllAddressApi();
    } catch (error) {
      // addresses!.addressList.removeWhere((element) => element.id == id);
      // await getAllAddressApi();
      debugPrint("messgae:$error");
    }
  }

  // getAddress for shopify library
  getAllAddressApi() async {
    try {
      isPageLoad.value = true;
      noData.value = true;
      ShopifyUser? shopifyUser = await ShopifyAuth.instance.currentUser();
      print(await ShopifyAuth.instance.currentCustomerAccessToken);
      print(" vgfjsnzxvgfvcg");
      addresses = Addresses(addressList: []);
      addresses = shopifyUser!.address;
      print(" vgfvgfvcg ${shopifyUser.id.toString()}");
      email = shopifyUser.email.toString();
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
      // failedToast(exception.toString()); // 7819eb0ff96a1d4c9477a563e3517ddc, 7819eb0ff96a1d4c9477a563e3517ddc
    }
  }

  stringIDGet(input) {
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
