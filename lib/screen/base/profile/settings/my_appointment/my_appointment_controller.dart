import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/common_function.dart';

import '../../../../../api_provider/api_provider.dart';
import '../../../../../model/book_appointment_model.dart';
import '../../../../../model/my_all_book_appointment_model.dart';
import '../../../../../util/app_colors.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/res_dimens.dart';

class MyAppointmentController extends GetxController {
  var pageLoaderService = true.obs;
  var dataMyAllBooking = <DataMyAllBooking>[].obs;
  var dataMyAllFilter = <DataMyAllBooking>[].obs;

  var isLoading = false.obs;

  var isUpcomingCompleteStatus = "upcoming".obs;

  @override
  void onInit() {
    pageLoaderService.value = true;
    getAllServicesList();
    super.onInit();
  }

  // Call this method to populate completed and pending item lists
  void updateStatusLists() {
    if(isUpcomingCompleteStatus.value=='upcoming') {
      dataMyAllFilter.value = dataMyAllBooking
          .where((item) =>
      item.bookingStatus.toString().toUpperCase() != 'COMPLETED')
          .toList();
    } else {
      dataMyAllFilter.value = dataMyAllBooking
          .where((item) =>
      item.bookingStatus.toString().toUpperCase() == 'COMPLETED')
          .toList();
    }
  }

  getAllServicesList() async {
    try {
      var status = "";
      MyAllBookAppointmentModel myAllBookAppointmentModel =
          await ApiProvider.booking().getMyAllSlotsList(status);
      pageLoaderService.value = false;
      if (myAllBookAppointmentModel.result == 1) {
        dataMyAllBooking.value = myAllBookAppointmentModel.dataMyAllBooking!;
        print("xbnzm==> ${dataMyAllBooking.length}");
        updateStatusLists();
      }
      print("jhsdfxgcdhdA==> ${myAllBookAppointmentModel.msg}");
    } on HttpException catch (exception) {
      print(exception.message);
      pageLoaderService.value = false;
    } catch (exception) {
      pageLoaderService.value = false;
      print("sadafgxhzBldksxJNK==> ${exception.toString()}");
    }
  }

  getCancelBooking(bookingId) async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> requestBody = {
        'booking_id': bookingId,
        'booking_status': 'cancelled',
      };
      BookAppointmentModel bookAppointmentModel =
          await ApiProvider.booking().getCancelBooking(requestBody);
      if (bookAppointmentModel.result == 1) {
        print("xbnzm==> ${dataMyAllBooking.length}");
        successToast("Booking cancelled successfully.");
        updateStatusLists();
      }
      isLoading.value = false;
      print("jhsdfxgcdhdA==> ${bookAppointmentModel.msg}");
    } on HttpException catch (exception) {
      print(exception.message);
      isLoading.value = false;
      successToast("Booking cancelled failed.");
    } catch (exception) {
      print("sadafgxhzBJNK==> ${exception.toString()}");
      successToast("Booking cancelled failed.");
      isLoading.value = false;
    }
  }

  Color getStatusColor({required String status}) {
    switch (status) {
      case 'PENDING':
        return Colors.orangeAccent; // Set the color for 'PENDING' status
      case 'CONFIRMED':
        return Colors.blue; // Set the color for 'COMPLETED' status
      case 'COMPLETED':
        return Colors.green; // Set the color for 'CONFIRMED' status
      case 'CANCELLED':
        return Colors.red; // Set the color for 'CANCELLED' status
      default:
        return Colors.black; // Set a default color for unknown statuses
    }
  }

  String getStatusIcon({required String status}) {
    switch (status) {
      case 'PENDING':
        return Assets.icPending; // Set the color for 'PENDING' status
      case 'CONFIRMED':
        return Assets.icConfirm; // Set the color for 'CONFIRMED' status
      case 'COMPLETED':
        return Assets.icComplete; // Set the color for 'COMPLETED' status
      case 'CANCELLED':
        return Assets.icRemove; // Set the color for 'CANCELLED' status
      default:
        return Assets.appIconLogo; // Set a default color for unknown statuses
    }
  }

  cancelConfirmation(context, bookingId) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 15),
                          child: Image.asset(
                            Assets.cancel,
                            height: 15,
                            width: 15,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text("booking_cancel".tr,
                          style: AppStyles.textStyle(
                              fontSize: dimen18, weight: FontWeight.normal)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Center(
                        child: Text("booking_cancel_disc".tr,
                            style: AppStyles.textStyle(
                              fontSize: 14.0,
                              weight: FontWeight.normal,
                            )),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Spacer(),
                    const Divider().marginOnly(bottom: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                              child: Text("no".tr,
                              style: AppStyles.textStyle(
                                fontSize: 17.0,
                                color: AppColors.black,
                                weight: FontWeight.normal,
                              )),
                            ),
                          ),
                        ),
                        Container(
                          height: 35,
                          color: AppColors.lightGrey,
                          width: 1,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              getCancelBooking(bookingId);
                            },
                            child: Center(
                              child: Text("yes".tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17.0,
                                    color: AppColors.red2C,
                                    fontFamily: 'JosefinSans',
                                    // decoration: TextDecoration.underline,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
