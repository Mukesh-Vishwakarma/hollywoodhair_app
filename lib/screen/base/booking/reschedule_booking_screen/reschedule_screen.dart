import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/screen/base/booking/reschedule_booking_screen/reschedule_controller.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RescheduleScreen extends GetView<RescheduleController> {
  const RescheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                backgroundColor: AppColors.colorFF,
                titleSpacing: 0.0,
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
                title: Text('book_appointment'.tr,
                    style: AppStyles.textStyle(
                        fontSize: 16.0, weight: FontWeight.normal)),
                automaticallyImplyLeading: false,
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(
                    () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("Date",
                          style: AppStyles.textStyle(
                              fontSize: 14.0, weight: FontWeight.normal)),
                    ),
                    Form(
                      key: controller.formBookingKey,
                      child: Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 15),
                          child: TextFormField(
                            readOnly: true,
                            controller: controller.dateTimeController,
                            focusNode: controller.dateFocusNode,
                            onTap: () async {
                              DateTime? newDateTime =
                              await showRoundedDatePicker(
                                context: context,
                                description: "date_journey".tr,
                                theme: ThemeData(primarySwatch: controller.orange),
                                height: 300,
                                initialDate: (controller
                                    .dateTime.value.isNotEmpty)
                                    ? DateTime.parse(controller.dateTime.value)
                                    : DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 100),
                                lastDate: DateTime(2030, 12, 12),
                                borderRadius: 30,
                              );
                              final DateFormat formatterView =
                              DateFormat('d MMMM yyyy');
                              String formattedView =
                              formatterView.format(newDateTime!);
                              controller.dateTimeController.text =
                                  formattedView;
                              final DateFormat formatterApi =
                              DateFormat('yyyy-MM-dd');
                              String formattedApi =
                              formatterApi.format(newDateTime);
                              controller.dateTime.value = formattedApi;
                              print('DateJourney');
                              print(controller.dateTime.value);
                              if (controller.dateTime.value != '') {
                                controller.getAvailableSlotsList(
                                    controller.dateTime.value);
                              }
                            },
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "date".tr;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              controller.dateTime.value = value;
                            },
                            decoration: InputDecoration(
                              isDense: false,
                              contentPadding: const EdgeInsets.all(15),
                              hintText: "date".tr,
                              hintStyle: AppStyles.textStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                                weight: FontWeight.normal,
                              ),
                              suffixIcon:
                              const Icon(Icons.calendar_month_outlined),

                              // labelText: "date".tr,
                              labelStyle: AppStyles.textStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                                weight: FontWeight.normal,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: AppColors.colorCD, width: 0.99),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: AppColors.colorCD, width: 0.99),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 0,
                                ),
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("Available slots",
                          style: AppStyles.textStyle(
                              fontSize: 14.0, weight: FontWeight.normal)),
                    ),
                    (controller.availableSlotsList.isNotEmpty)
                        ? Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Wrap(
                          spacing: 3.0,
                          runSpacing: 0.0,
                          children: List.generate(
                            controller.availableSlotsList.length,
                                (index) => Obx(
                                  () => GestureDetector(
                                onTap: () {
                                  if (controller.availableSlotsList[index]
                                      .isAvail!) {
                                    controller.timeSlot.value = controller
                                        .availableSlotsList[index]
                                        .slotName
                                        .toString();
                                    controller.timeSlotId.value =
                                        controller
                                            .availableSlotsList[index]
                                            .slotId
                                            .toString();
                                  } else {
                                    successToast(
                                        "This slots is already booked.");
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, top: 10),
                                  child: (Chip(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(8),
                                      side: BorderSide(
                                          color: controller
                                              .availableSlotsList[
                                          index]
                                              .isAvail!
                                              ? AppColors.grayDA
                                              : AppColors.promoborder),
                                    ),
                                    backgroundColor: (controller
                                        .timeSlotId.value
                                        .toString() !=
                                        controller
                                            .availableSlotsList[index]
                                            .slotId
                                            .toString())
                                        ? controller
                                        .availableSlotsList[index]
                                        .isAvail!
                                        ? AppColors.backGroundColor
                                        : AppColors.promoborder
                                        : AppColors.primaryColor,
                                    label: Text(
                                      controller.availableSlotsList[index]
                                          .slotName
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: (controller
                                              .timeSlotId.value
                                              .toString() !=
                                              controller
                                                  .availableSlotsList[
                                              index]
                                                  .slotId
                                                  .toString())
                                              ? controller
                                              .availableSlotsList[
                                          index]
                                              .isAvail!
                                              ? Colors.black
                                              : AppColors.black84
                                              : AppColors
                                              .backGroundColor),
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ).toList()),
                    )
                        : SizedBox(
                      width: 100.w,
                      child: const Align(
                        alignment: Alignment.center,
                        // child: const Text('No slots found').marginOnly(top: 50),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                          () => !controller.isPageLoad.value
                          ? GestureDetector(
                        onTap: () {
                          if (!controller.formBookingKey.currentState!
                              .validate()) {
                            print("not validate");
                          } else {
                            // controller.bookingFinal();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 80, bottom: 10),
                          child: buttom("Book appointment"),
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 80, bottom: 10),
                        child: Container(
                          width: Get.size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: AppColors.color7C,
                          ),
                          child: const Center(
                            child: Padding(
                              padding:
                              EdgeInsets.only(top: 15, bottom: 15),
                              child: SpinKitThreeBounce(
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )),
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
}
