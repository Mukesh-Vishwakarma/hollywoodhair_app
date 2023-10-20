import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopify_flutter/models/src/shopify_user/addresses/addresses.dart';
import 'package:shopify_flutter/shopify/src/shopify_auth.dart';
import '../../api_provider/api_provider.dart';
import '../../model/shopify_model/get_address_model.dart';
import '../../util/app_constants.dart';
import '../tryOn_screen/tryOn_screen.dart';
import 'booking/booking_screen.dart';
import 'cart_screen/cart_screen.dart';
import 'home_screen/home_screen.dart';
import 'profile/profile_screen.dart';

class BaseHomeController extends GetxController {
  var selectedIndex = 0.obs;
  var baseChildren = <Widget>[].obs;
  var totalMessageCount = "0".obs;

  var defaultAddress = true;
  Addresses? addresses;
  var addressesListNew = GetAddressModel().obs;

  @override
  void onInit() {
    var screenType = Get.arguments["screenType"] ?? "";
    if (screenType == "product details") {
      selectedIndex.value = 3;
    }

    baseChildren.value = [
      HomeScreen(),
      BookingScreen(),
      TryOnScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    try {
      getUserAddress();
    } catch (e) {
      print("ldkss");
    }

    super.onInit();
  }

  onItemSelect(index) {
    selectedIndex.value = index;
    refresh();
  }

  // shopifyGetData() async {
  //   ShopifyAuth shopifyAuth = ShopifyAuth.instance;
  //   ShopifyUser? value = await shopifyAuth.currentUser();
  //   ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
  //   final checkout1 = await shopifyCheckout.createCheckout(
  //     lineItems: [
  //       LineItem(
  //           variantId: "gid://shopify/ProductVariant/47337289744719",
  //           title: "Example Pants",
  //           quantity: 1,
  //           id: "gid://shopify/Product/8678460686671")
  //     ],
  //   );
  //   print(checkout1.webUrl);
  //   // final checkout1 = await shopifyCheckout.getCheckoutInfoWithAvailableShippingRatesQuery("gid://shopify/Checkout/de2074ccb9401ec81700e8045ea40639?key=906aa3476fc11b4fb4c085aceda5bbc7");
  //   final checkout = await shopifyCheckout.getCheckoutInfoQuery(checkout1.id);
  //   print(checkout.webUrl);
  //   // shopifyAuth.currentCustomerAccessToken;
  // }

  // getUserOrders() async {
  //   try {
  //     final input = await GetStorage().read(AppConstants.userId);
  //     final customerId = input.split('/').last;
  //     UserOrdersModel getAddressModel =
  //     await ApiProvider.shopify().getMyOrdersByCustomerId(customerId: customerId);
  //
  //     orderStatus.value = false;
  //     print("jhbzxnjkm");
  //     userOrdersModel.value = getAddressModel;
  //
  //     GetStorage().write(AppConstants.myOrderedProductsCount, userOrdersModel.value.orders!.length.toString());
  //
  //   } on HttpException catch (exception) {
  //     orderStatus.value = false;
  //     print(exception.message);
  //     GetStorage().write(AppConstants.myOrderedProductsCount, "");
  //   } catch (exception) {
  //     orderStatus.value = false;
  //     print(exception.toString());
  //     GetStorage().write(AppConstants.myOrderedProductsCount, "");
  //   }
  // }

  getUserAddress() async {
    try {
      var defaultAddress = GetStorage().read(AppConstants.addressId);
      final input = await GetStorage().read(AppConstants.userId);
      final customerId = input.split('/').last;
      GetAddressModel getAddressModel =
          await ApiProvider.shopify().getAddressShopify(customerId: customerId);
      print(await ShopifyAuth.instance.currentCustomerAccessToken);
      print(" vgfjsnzxvgfvcg");
      addresses = Addresses(addressList: []);
      addressesListNew.value = getAddressModel;
      print(" vgfvgfvcg ${getAddressModel.addresses![0].id.toString()}");

      if (defaultAddress.toString() != "default") {
        for (int i = 0; i < getAddressModel.addresses!.length; i++) {
          if (getAddressModel.addresses![i].defaultAddress == true) {
            GetStorage().write(AppConstants.sippingAddress, true);
            GetStorage().write(AppConstants.companyName,
                getAddressModel.addresses![i].company.toString());
            GetStorage().write(AppConstants.customerAddressName,
                getAddressModel.addresses![i].name.toString());
            GetStorage().write(AppConstants.mobileNo,
                getAddressModel.addresses![i].phone.toString());
            GetStorage().write(AppConstants.city,
                getAddressModel.addresses![i].city.toString());
            GetStorage().write(AppConstants.country,
                getAddressModel.addresses![i].country.toString());
            GetStorage().write(AppConstants.postelCode,
                getAddressModel.addresses![i].zip.toString());
            GetStorage().write(AppConstants.address1,
                getAddressModel.addresses![i].address1.toString());
            GetStorage().write(AppConstants.address2,
                getAddressModel.addresses![i].address2.toString());
            GetStorage().write(AppConstants.addressId,
                getAddressModel.addresses![i].id.toString());
            GetStorage().write(AppConstants.firstName,
                getAddressModel.addresses![i].firstName.toString());
            GetStorage().write(AppConstants.lastName,
                getAddressModel.addresses![i].lastName.toString());
          }
        }
      }
    } on HttpException catch (exception) {
      print(exception.toString());
    } catch (exception) {
      print(exception.toString());
    }
  }
}
