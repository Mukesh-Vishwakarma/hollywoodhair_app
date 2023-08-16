import 'dart:async';

import 'package:get/get.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {

var image = Assets.textImage;

  @override
  void onInit() {

    // Future.delayed(const Duration(seconds: 3),  switchScreen());
    // hideBottomButton();
    super.onInit();
    switchScreen();
  }


  switchScreen() async {
    Timer(Duration(seconds: 2), () {
      // Get.offNamed(AppPages.signInScreen,);//It will redirect  after 1 seconds
      Get.offNamed(AppPages.profileScreen,);
      //It will redirect  after 1 seconds
    });
    // Future.delayed(Duration(seconds: 1), () {
    //   return

    // });

  }

}