import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../util/assets.dart';
import 'booking_controller.dart';

class BookingScreen extends GetView<BookingController> {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        // Assets.demo3,
        Assets.splashButtom,
        height: MediaQuery.of(context).size.height / 1.6,
        width: MediaQuery.of(context).size.width,
        // fit: BoxFit.cover,
        fit: BoxFit.fitHeight,
      ).marginOnly(top: 10),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: GestureDetector(
                // onTap: () {
                //   Get.back();
                // },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(.35),
                      shape: BoxShape.circle),
                  // child: const Icon(
                  //   Icons.arrow_back,
                  //   color: AppColors.lightBackgroundColor,
                  // ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: const EdgeInsets.only(left: 0, right: 0, top: 10),
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 15, bottom: 15),
                  width: Get.size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                    border: Border.all(
                      color: AppColors.colorD3,
                    ),
                    color: AppColors.lightBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 20),
                        child: Text("Style Selection Consultation",
                            style: AppStyles.textStyle(
                                color: AppColors.black,
                                fontSize: 18.0,
                                weight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                            "Get expert advice on your hair styling! Book an online consultation with our hair experts to find your perfect look.",
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyle(
                                color: AppColors.gray99,
                                fontSize: 12.0,
                                weight: FontWeight.w500)),
                      ),
                      GestureDetector(
                        onTap: () {
                          /* try {
                            if (Get.isRegistered<CalendlyController>()) {
                              Get.toNamed(AppPages.calendlyScreen);
                            } else {
                              Get.put(CalendlyController());
                              Get.toNamed(AppPages.calendlyScreen);
                            }
                          } catch (e){
                            print("nxmjxcjnj");
                          }*/
                          Get.toNamed(AppPages.bookingFormScreen);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 20),
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: AppColors.color7C,
                          ),
                          child: Row(
                            children: [
                              // Expanded(child: Container(),),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 100),
                                child: Text(
                                  "book_consultation".tr,
                                  style: AppStyles.textStyle(
                                    color: AppColors.lightBackgroundColor,
                                    fontSize: 12.0,
                                    weight: FontWeight.normal,
                                  ),
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset(
                                  Assets.whiteArrow,
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      )
    ]);
  }
}
