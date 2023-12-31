import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import '../../../../../model/my_all_book_appointment_model.dart';
import '../../../../../util/common_function.dart';
import 'my_appointment_controller.dart';

class MyAppointmentScreen extends GetView<MyAppointmentController> {
  const MyAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              backgroundColor: AppColors.colorFF,
              titleSpacing: 0,
              elevation: 0.5,
              leading: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        50), // Set the same rounded border as Material
                  ),
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                  )),
              title: Text("my_appointment".tr,
                  style: AppStyles.textStyle(
                      fontSize: 16.0, weight: FontWeight.normal)),
              automaticallyImplyLeading: false,
            ),
          ),
          body: Column(
            children: [
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          controller.isUpcomingCompleteStatus.value =
                              "upcoming";
                          controller.updateStatusLists();
                        },
                        child: Column(
                          children: [
                            Center(
                              child: Text("upcoming".tr.toUpperCase(),
                                  style: AppStyles.textStyle(
                                      color: (controller
                                                  .isUpcomingCompleteStatus
                                                  .value ==
                                              'upcoming')
                                          ? AppColors.primaryColorDark
                                          : AppColors.black,
                                      fontSize: 15.0,
                                      weight: FontWeight.w500)).marginOnly(bottom: 5),
                            ),
                            if ((controller.isUpcomingCompleteStatus.value ==
                                'upcoming'))
                              Container(
                                height: 3,
                                width: 90,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: AppColors.primaryColor,
                                ),
                              ),
                          ],
                        ).marginOnly(top: 10),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          controller.isUpcomingCompleteStatus.value =
                              "completed";
                          controller.updateStatusLists();
                        },
                        child: Column(
                          children: [
                            Center(
                              child: Text("completed".tr.toUpperCase(),
                                  style: AppStyles.textStyle(
                                      color: (controller
                                                  .isUpcomingCompleteStatus
                                                  .value ==
                                              'completed')
                                          ? AppColors.primaryColorDark
                                          : AppColors.black,
                                      fontSize: 15.0,
                                      weight: FontWeight.w500)).marginOnly(bottom: 5),
                            ),
                            if ((controller.isUpcomingCompleteStatus.value ==
                                'completed'))
                              Container(
                                height: 3,
                                width: 90,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: AppColors.primaryColor,
                                ),
                              ),
                          ],
                        ).marginOnly(top: 10),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1.0,
                color: AppColors.lightGrey,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(() => !controller.pageLoaderService.value
                      ? controller.dataMyAllFilter.isNotEmpty
                          ? SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                shrinkWrap: true,
                                reverse: false,
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.dataMyAllFilter.length,
                                itemBuilder: (context, index) {
                                  return itemMyAppointments(
                                      controller.dataMyAllFilter[index],
                                      context);
                                },
                              ),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: noDataFound(),
                            )
                      : shimmerDemo()),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.isLoading.value,
            child: Container(
              color: AppColors.transparentBlack,
              child: const SpinKitFadingCircle(
                color: Colors.white,
                size: 70.0,
              ).marginOnly(top: 70),
            ),
          ),
        )
      ],
    );
  }

  itemMyAppointments(DataMyAllBooking dataMyAllBooking, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: Row(
            children: [
              Text(
                dataMyAllBooking.bookingStatus.toString().toUpperCase(),
                style: AppStyles.textStyle(
                  color: controller.getStatusColor(
                      status: dataMyAllBooking.bookingStatus
                          .toString()
                          .toUpperCase()),
                  fontSize: 14.0,
                  weight: FontWeight.normal,
                ),
              ),
              Image.asset(
                controller.getStatusIcon(
                  status:
                      dataMyAllBooking.bookingStatus.toString().toUpperCase(),
                ),
                height: 15,
                width: 15,
                color: controller.getStatusColor(
                    status: dataMyAllBooking.bookingStatus
                        .toString()
                        .toUpperCase()),
              ).marginOnly(
                left: 5,
              )
            ],
          ),
        ),
        Container(
            // height: 100,
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            padding:
                const EdgeInsets.only(top: 15, bottom: 0, left: 0, right: 0),
            width: Get.size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.colorD9,
                width: 1.0,
              ),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              (dataMyAllBooking.servicedetails!.isNotEmpty)
                                  ? dataMyAllBooking
                                      .servicedetails![0].serviceName
                                      .toString()
                                  : '',
                              style: AppStyles.textStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                  weight: FontWeight.w500)),
                          const SizedBox(height: 7),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6, right: 8),
                                          child: Image.asset(
                                            Assets.calender,
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Date",
                                                  style: AppStyles.textStyle(
                                                      color: AppColors.gray99,
                                                      fontSize: 14.0,
                                                      weight:
                                                          FontWeight.normal)),
                                              Text(
                                                  dataMyAllBooking.bookingDate
                                                      .toString(),
                                                  style: AppStyles.textStyle(
                                                      color: AppColors.black,
                                                      fontSize: 14.0,
                                                      weight: FontWeight.w500)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (dataMyAllBooking.workerName != null)
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6, right: 8),
                                            child: Image.asset(
                                              Assets.user,
                                              height: 20,
                                              // width: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Hairstylist",
                                                    style: AppStyles.textStyle(
                                                        color: AppColors.gray99,
                                                        fontSize: 14.0,
                                                        weight:
                                                            FontWeight.normal)),
                                                Text(
                                                    dataMyAllBooking.workerName
                                                        .toString(),
                                                    style: AppStyles.textStyle(
                                                        color: AppColors.black,
                                                        fontSize: 14.0,
                                                        weight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 6, right: 8),
                                    child: Image.asset(
                                      Assets.clock,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Time",
                                            style: AppStyles.textStyle(
                                                color: AppColors.gray99,
                                                fontSize: 14.0,
                                                weight: FontWeight.normal)),
                                        Text(
                                            (dataMyAllBooking
                                                    .slotsdetails!.isNotEmpty)
                                                ? dataMyAllBooking
                                                    .slotsdetails![0].slotName
                                                    .toString()
                                                : '',
                                            style: AppStyles.textStyle(
                                                color: AppColors.black,
                                                fontSize: 14.0,
                                                weight: FontWeight.w500)),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //
                const Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                  child: DottedLine(
                    dashColor: AppColors.gray99,
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              left: 0, top: 15, right: 15),
                          decoration: (BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          )),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Column(children: [
                                      (dataMyAllBooking.salonDetails != null)
                                          ? Image.network(
                                              dataMyAllBooking
                                                  .salonDetails!.salonThumbnail
                                                  .toString(),
                                              height: 70,
                                              width: 70,
                                              fit: BoxFit.cover,
                                            )
                                          : Container()
                                    ]))
                              ])),
                      Expanded(
                        child: (dataMyAllBooking.salonDetails != null)
                            ? Text(
                                dataMyAllBooking.salonDetails!.salonNameEn
                                    .toString(),
                                style: AppStyles.textStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    weight: FontWeight.normal))
                            : Container(),
                      )
                    ],
                  ),
                ),

                if (dataMyAllBooking.bookingStatus.toString().toUpperCase() !=
                    "COMPLETED")
                  const Divider(
                    color: AppColors.colorD9,
                    thickness: 1.0,
                  ).marginOnly(
                    top: 10,
                  ),
                if (dataMyAllBooking.bookingStatus.toString().toUpperCase() !=
                    "COMPLETED")
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (dataMyAllBooking.salonDetails != null) {
                              var result = await Get.toNamed(AppPages.rescheduleScreen,
                                  arguments: {
                                    // "saloon_id": dataMyAllBooking
                                    //     .salonDetails?.salonId
                                    //     .toString(),

                                    "saloon_id": '1',
                                    "booking_id": dataMyAllBooking.bookingId?.toString()
                                  });
                              print("dsvb==>- $result");
                              if(result=="Successful"){
                                controller.isLoading.value = true;
                                controller.getAllServicesList();
                              }
                            } else {
                              successToast("Some issues");
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 15),
                            width: Get.size.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                // topRight: Radius.circular(0.0),
                              ),
                              color: Colors.transparent,
                              // borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text("Reschedule",
                                  style: AppStyles.textStyle(
                                      color: AppColors.primaryColorDark,
                                      fontSize: 14.0,
                                      weight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ),
                      if (dataMyAllBooking.bookingStatus
                              .toString()
                              .toUpperCase() !=
                          "CANCELLED")
                        Container(
                          height: 32,
                          width: 1.0,
                          color: AppColors.colorD9,
                        ),
                      if (dataMyAllBooking.bookingStatus
                              .toString()
                              .toUpperCase() !=
                          "CANCELLED")
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.cancelConfirmation(context,
                                  dataMyAllBooking.bookingId.toString());
                            },
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 5, bottom: 15),
                                width: Get.size.width,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                  ),
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: Text("Cancel",
                                      style: AppStyles.textStyle(
                                          color: AppColors.primaryColorDark,
                                          fontSize: 14.0,
                                          weight: FontWeight.w500)),
                                )),
                          ),
                        ),
                    ],
                  )
              ],
            ))
      ],
    );
  }
}
