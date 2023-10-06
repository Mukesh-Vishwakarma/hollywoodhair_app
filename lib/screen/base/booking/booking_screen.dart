import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';

import 'booking_controller.dart';

class BookingScreen extends GetView<BookingController> {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: AppColors.colorFF,
          title: Text("booking_new".tr,
              style: AppStyles.textStyle(
                  fontSize: dimen15, weight: FontWeight.w500)),
          actions: const <Widget>[
            // GestureDetector(
            //   child: Padding(
            //     padding: const EdgeInsets.only(right: 20),
            //     child: Image.asset(
            //       Assets.search,
            //       height: 30,
            //       width: 30,
            //     ),
            //   ),
            //   onTap: () {
            //     // do something
            //   },
            // )
          ],
          automaticallyImplyLeading: false,
        ),
      ),
      body: SingleChildScrollView(
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
                }),
            // const SizedBox(height: 40),
            // const DottedLine(
            //   dashColor: AppColors.gray99,
            // ),
            // const SizedBox(height: 30),
            // GestureDetector(
            //   onTap: (){
            //     Get.toNamed(AppPages.myAppointmentScreen);
            //
            //   },
            //   child: Container(
            //     margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            //     padding: const EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 15),
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         color: AppColors.colorD3,
            //         // style: BorderStyle.solid,
            //         width: 1.0,
            //       ),
            //       color: Colors.transparent,
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            //     child: Row(
            //       children: [
            //         // Expanded(child: Container(),),
            //         Expanded(
            //             child: Padding(
            //           padding: const EdgeInsets.only(left: 100),
            //           child: Text(
            //             "my_appointments".tr,
            //             style: AppStyles.textStyle(
            //               color: AppColors.primaryColor,
            //               fontSize: dimen12,
            //               weight: FontWeight.normal,
            //             ),
            //           ),
            //         )),
            //         Image.asset(
            //           Assets.arrowRight,
            //           height:20,
            //           width: 20,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 130),
          ],
        ),
      ),
    );
  }

  bookingList(index) {
    return GestureDetector(
      onTap: (){
        if(index==1){
          Get.toNamed(AppPages.bookingFormScreen);
        }else{
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      controller.bookingList[index].text
                                          .toString(),
                                      style: AppStyles.textStyle(
                                          fontSize: dimen12,
                                          weight: FontWeight.w500)),
                                  // Text(
                                  //     controller.bookingList[index].description
                                  //         .toString(),
                                  //     style: AppStyles.textStyle(
                                  //         fontSize: dimen12,
                                  //         weight: FontWeight.normal)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Image.asset(
                              Assets.arrowRight,
                              height: 15,
                              width: 15,
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}
