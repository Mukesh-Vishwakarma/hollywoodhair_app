import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'booking_successful_controller.dart';

class BookingSuccessfulScreen extends GetView<BookingSuccessfulController> {
  const BookingSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              controller.textHeading.value,
              style: AppStyles.textStyle(
                  color: AppColors.black,
                  fontSize: 26.0,
                  weight: FontWeight.w500),
            )),
            Center(
                child: Text(
              controller.textDescription.value,
              style: AppStyles.textStyle(
                color: AppColors.black,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            )).marginOnly(top: 13)
          ],
        ),
      ),
    );
  }
}
