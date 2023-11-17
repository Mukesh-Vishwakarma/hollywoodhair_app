import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
String tag = 'api_provider';


const baseUrl = 'https://designoweb.co/hollywoodhair/api/';
const baseUrlBooking = 'https://designoweb.co/hollywoodhair/crm/api/';
const shopifyUrl = 'https://a02f54.myshopify.com/admin/';
const shopifyTokenUrl = 'https://a02f54.myshopify.com/';
//https://a02f54.myshopify.com/api/2023-07/graphql.json
const shopifyStorefrontUrl = 'https://a02f54.myshopify.com/api/2023-07/';
const shopifyCustomerUrl = 'https://a02f54.myshopify.com/';


const X_Shopify_Storefront_Access_Token = '549578c139b9579e72a9674e7873a1b5';


const String strGetRegister = 'user-signup';
const String strGetOtpLogin = 'otp-login';
const String strGetOtpVerify = 'otpverify';
const String strGetEmailLogin = 'email-login';
const String strGetProfileDetails = 'get-profile-details';
const String strUpdateProfileDetails = 'update-profile-details';
const String strNewPassword = 'change-password';
const String strGetAllAddress = 'get-all-address';
const String strAddAddress = 'add-address';
const String strGetAddressByID = 'get-address';
const String strDeleteAddress = 'delete-address';
const String strUpdateAddress = 'update-address';
const String strGetStaticPage = 'get-site-setting';
const String strChangePassword = 'change-customer-password';
const String strGetProductList = 'getProductList';
const String strGetProductByID = 'getProductById';
const String strGetAllSalons = 'getAllSalons';
const String strGetFeaturedProducts = 'getFeaturedProducts';
const String strGetAllTransformations = 'getAllTransformationsImages';
const String strGetAllServices = 'service';
const String strGetWorkerBySalon = 'worker/getWorkerBySalon';
const String strGetAvailability = 'salons/getAvailability';
const String strGetBooking = 'salons/booking';
const String strGetAllBooking = 'salons/allbooking';
const String strGetUpdateBookingStatus = 'salons/updateBookingStatus';
const String strGetUpdateBookingSchedule = 'salons/updateBookingSchedule';
const String strGetAllCategories = 'getAllCategories';

//shopify end points

const String loginShopify = 'graphql.json';
const String userDetailsShopify = 'customers.json';
const String addCartShopify = 'cart/add.json';
const String categoryShopify = 'custom_collections.json';
const String getCartShopify = 'cart.json';




handleException(error,stacktrace,DioError dioError){
  debugPrint("Exception occurred: $error stackTrace: $stacktrace");
  if (dioError.response!.statusCode == 401) {
    throwIfNoSuccess("unauthorized".tr);
  } else if (dioError.response!.statusCode == 500) {
    if (dioError.response!.data == null) {
      throwIfNoSuccess("server_error".tr);
    } else {
      throwIfNoSuccess(dioError.response!.data['message']);
    }
  } else {
    if (dioError.response!.data == null) {
      throwIfNoSuccess("something_went_wrong".tr);
    } else {
      throwIfNoSuccess(dioError.response!.data['message']);
    }
  }
}

void throwIfNoSuccess(String response) {
  throw HttpException(response);
}