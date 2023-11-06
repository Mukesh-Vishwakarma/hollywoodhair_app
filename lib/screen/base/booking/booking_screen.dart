import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'booking_controller.dart';

class BookingScreen extends GetView<BookingController> {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: AppBar(
          backgroundColor: AppColors.colorFF,
          title: Text("booking_new".tr,
              style:
                  AppStyles.textStyle(fontSize: 20.0, weight: FontWeight.w500)),
          automaticallyImplyLeading: false,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 30),
            ListView.builder(
              // scrollDirection: Axis.vertical,
              shrinkWrap: true,
              reverse: false,
              itemCount: controller.bookingList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return bookingList(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  bookingList(index) {
    return GestureDetector(
      onTap: () {
        if (index == 1) {
          Get.toNamed(AppPages.bookingFormScreen);
        } else {
          // name: AppPages.confirmBookingScreen
          Get.toNamed(AppPages.confirmBookingScreen);
        }
      },
      child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          padding: const EdgeInsets.only(bottom: 10),
          // height: 200,
          width: Get.size.width,
          decoration: (BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  children: [
                    Image(
                        height: 270,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        image: AssetImage(
                            controller.bookingList[index].image.toString())),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    controller.bookingList[index].text
                                        .toString(),
                                    style: AppStyles.textStyle(
                                        fontSize: 12.0,
                                        weight: FontWeight.w500)),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 3.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
