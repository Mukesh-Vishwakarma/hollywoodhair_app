import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

String tag = 'api_provider';


// const baseUrl = 'http://52.73.22.86/api/';
// const baseUrl = 'https://designoweb.co/seriousdating/api/';
// const baseUrl = 'http://34.206.46.120/api/';
const baseUrl = 'http://16.171.168.73/api/';

const String strGetRegister = 'register';
const String strGetSocialLogin = 'socialLogin';
const String strGetOtpVerification = 'otpVerification';
const String strGetPersonalDetails = 'personalDetails';
const String strGetAllCountries = 'getAllCountries';
const String strGetMoreAboutDetails = 'moreAboutDetails';
const String strGetInterestList = 'getInterestList';
const String strGetHeightList = 'getHeightList';
const String strGetUserDetails = 'getUserDetails';
const String strGetCityByCountryId = 'getCityByCountryId';
const String strGetChooseYourInterest = 'chooseYourInterest';
const String strGetLatLong = 'setLatLong';
const String strGetProfileImages = 'setProfileImages';
const String strGetUpdateProfile = 'updateProfile';
const String strGetHomeApi = 'homeApi';
const String strGetStaticPages = 'staticPages';
const String strSetProfileImages = 'setProfileImages';
const String strSetOrDeleteProfileImage = 'setOrDeleteProfileImage';
const String strSetSwipeLeftRight = 'swipeLeftRight';
const String strAddSuperLike = 'addSuperlike';
const String strJobActivityList = 'jobActivityList';
const String strSetRequestMatch = 'requestMatch';
const String strGetNotifications = 'getNotifications';
const String strDeleteOrDisableAccount = 'deleteOrDisableAccount';
const String strGetChatList = 'getChatList';
const String strGetChatDetails = 'getchatDetails';
const String strSendMessage = 'sendMessage';
const String strUserReport = 'userReport';
const String strUserBlock = 'userblock';
const String strGetBlockUsers = 'getBlockUsers';
const String strGetSubscriptionList = 'subscriptionList';
const String strGetUpgradePlan = 'upgradePlan';
const String strGetSubscription = 'getSubscription';
const String strTotalMessages = 'getTotalMessages';
const String strUserStatus = 'setUserstatus';
const String strOnlineStaus = 'getOnlineStaus';
const String strFirebaseToken = 'setFirebaseToken';


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