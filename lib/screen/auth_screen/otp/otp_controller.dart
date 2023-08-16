import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  Duration myDuration = const Duration(minutes: 1);

  var contactNumber = "".obs;

  // var userData = UserData().obs;
  Timer? timer;

  // var secondsRemaining = 60.obs;
  // var enableResend = false.obs;
  var time = '02:00'.obs;

  // var remainingSeconds = 0;
  var isResend = false.obs;
  var currentText = "".obs;
  var otp = "".obs;
  var remainingSeconds = 0;
  // @override
  // void onReady() {
  //   startTimer();
  //   super.onReady();
  // }

  @override
  void onInit() {
    startTimer(120);
    // contactNumber.value = Get.arguments['phone_number'] ?? "";
    super.onInit();
  }

  startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        isResend.value = true;
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value =
        "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(
            2, "0")}";

        isResend.value = false;
        remainingSeconds--;
      }
    });
  }

  void setCountDown() {
    final reduceSecondsBy = 1;

    final seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {

      timer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
  }

  void stopTimer() {
    timer!.cancel();
  }




  @override
  void dispose() {
    otpController.clear();
    print("anything");
    super.dispose();
  }




}
