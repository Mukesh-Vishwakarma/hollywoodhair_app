import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/api_provider/api_provider.dart';
import 'package:hollywood_hair/model/user_model.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shopify_flutter/models/src/shopify_user/shopify_user.dart';
import 'package:shopify_flutter/shopify/src/shopify_auth.dart';

class ProfileController extends GetxController {
  var urlImage = "".obs;
  var fileImage = "".obs;
  Future<File>? imageFile;
  var userName = "".obs;
  var shortName  = "".obs;
  var phoneNumber = "".obs;
  var userID ="".obs;

  ShopifyAuth shopifyAuth = ShopifyAuth.instance;


  @override
  void onInit() {

    try {
      userName.value = GetStorage().read(AppConstants.userName);
      String fullName = userName.value;
      List<String> words = fullName.split(" ");
      List<String> initials = words.map((word) => word.substring(0, 1)).toList();
      shortName.value = initials.join();

      getCurrentUser();
      // getProfileApi();
    } catch (e){
      print("hgsdjbxknzl==> $e");
    }
    super.onInit();
  }


  getCurrentUser() async {
    ShopifyUser? shopifyUser = await shopifyAuth.currentUser();
    print("djfbshxnkmk==> ${shopifyUser!.firstName}");
    print("djfbshxnkmk==> ${shopifyUser!.lastName}");
    print("djfbshxnkmk==> ${shopifyUser!.email}");
    print("djfbshxnkmk==> ${shopifyUser!.phone}");
    print("djfbshxnkmk==> ${shopifyUser!.firstName}");
    print("djfbshxnkmk==> ${shopifyUser!.firstName}");
  }

//   editScreenRoute() async {
//     var result = await Get.toNamed(AppPages.editProfileScreen);
//     print("result>>>$result");
//     if (result != null) {
//       if (result == true) {
//         await getProfileApi();
//       }
//     }
//   }
//
// //**** api for get profile
//   getProfileApi() async {
//     userID.value = GetStorage().read(AppConstants.userId)??"";
//
//     try {
//       dio.FormData params = dio.FormData.fromMap({
//         'customer_id':userID.value,
//       });
//       print('create Data');
//       print(params.toString());
//       UserModel userModel = await ApiProvider.base().funGetProfile(params);
//       // progressDialog.dismiss();
//       print('create Data');
//       print(userModel.result);
//       if (userModel.result == "1") {
//         userID.value = GetStorage().read(AppConstants.userId)??"";
//         userName.value =  userModel.data!.customerName?? "";
//
//         String fullName = userName.value;
//         List<String> words = fullName.split(" ");
//         List<String> initials = words.map((word) => word.substring(0, 1)).toList();
//         shortName.value = initials.join();
//
//         print("hsgvdjxknzl==> ${shortName.value}");
//
//         phoneNumber.value = "${userModel.data!.customerCountryCode?? ""}"   "${userModel.data!.customerPhone?? ""}";
//         urlImage.value = userModel.data!.profileImage??"";
//         print("phone number1 >>> ${phoneNumber.value}");
//         print("phone number2 >>> ${userModel.data!.customerName}");
//         print("phone number3 >>> ${userModel.data!.customerCountryCode}");
//         print("phone number3 >>> ${userModel.data!.customerPhone?? ""}");
//
//       } else {
//         // successToast(userModel.message!);
//       }
//     } on HttpException catch (exception) {
//       // progressDialog.dismiss();
//       print(exception.message);
//       // failedToast(exception.message);
//     } catch (exception) {
//       // progressDialog.dismiss();
//       print(exception.toString());
//       // failedToast(exception.toString());
//     }
//   }

}
