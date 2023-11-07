import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../util/no_data.dart';
import '../../../../util/theme_service.dart';
import 'book_appointment_controller.dart';

class BookAppointmentScreen extends GetView<BookAppointmentController> {
  const BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                backgroundColor: AppColors.colorFF,
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
                        fontSize: dimen15, weight: FontWeight.normal)),
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
                      child: Text("Preferred Hairstylist (optional)",
                          style: AppStyles.textStyle(
                              fontSize: 14.0, weight: FontWeight.normal)),
                    ),
                    Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: TextFormField(
                          controller: controller.nameController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "name".tr;
                            }
                            return null;
                          },
                          onTap: () {
                            artistPickerBottomSheet();
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            isDense: false,
                            contentPadding: const EdgeInsets.all(15),
                            hintText: "name".tr,
                            hintStyle: AppStyles.textStyle(
                              color: AppColors.black,
                              fontSize: 14.0,
                              weight: FontWeight.normal,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                Assets.dropDown,
                              ),
                            ),

                            // labelText: "name".tr,
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
                                theme: ThemeData(primarySwatch: Colors.blue),
                                height: 300,
                                initialDate: (controller.dateTime.value.isNotEmpty)
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Wrap(
                          spacing: 3.0,
                          runSpacing: 0.0,
                          children: List.generate(
                            controller.availableSlotsList.length,
                            (index) => Obx(
                              () => GestureDetector(
                                onTap: () {
                                  if (controller
                                      .availableSlotsList[index].isAvail!) {
                                    controller.timeSlot.value = controller
                                        .availableSlotsList[index].slotName
                                        .toString();
                                    controller.timeSlotId.value = controller
                                        .availableSlotsList[index].slotId
                                        .toString();
                                  } else {
                                    successToast(
                                        "This slots is already booked.");
                                  }
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(left: 5, top: 10),
                                  child: (Chip(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                          color: controller
                                                  .availableSlotsList[index]
                                                  .isAvail!
                                              ? AppColors.grayDA
                                              : AppColors.promoborder),
                                    ),
                                    backgroundColor: (controller
                                                .timeSlotId.value
                                                .toString() !=
                                            controller.availableSlotsList[index]
                                                .slotId
                                                .toString())
                                        ? controller.availableSlotsList[index]
                                                .isAvail!
                                            ? AppColors.backGroundColor
                                            : AppColors.promoborder
                                        : AppColors.primaryColor,
                                    label: Text(
                                      controller
                                          .availableSlotsList[index].slotName
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: (controller.timeSlotId.value
                                                      .toString() !=
                                                  controller
                                                      .availableSlotsList[index]
                                                      .slotId
                                                      .toString())
                                              ? controller
                                                      .availableSlotsList[index]
                                                      .isAvail!
                                                  ? Colors.black
                                                  : AppColors.black84
                                              : AppColors.backGroundColor),
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ).toList()),
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
                          controller.bookingFinal();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 80, bottom: 10),
                        child: buttom("Book appointment"),
                      ),
                    ): Padding(
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
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),),
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

  ///  Services list bottom sheet
  artistPickerBottomSheet() {
    Get.bottomSheet(
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(0)),
          padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 20),
          child: Wrap(
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 13),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Container(
                  color: ThemeService().loadThemeFromBox()
                      ? AppColors.color18
                      : AppColors.lightBackgroundColor,
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 20, bottom: 10, top: 20),
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: ThemeService().loadThemeFromBox()
                              ? AppColors.color18
                              : AppColors.colorF6,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              child: Icon(Icons.search_rounded,
                                  size: 25, color: textThemeColor()),
                            ),
                            Expanded(
                              child: TextField(
                                  enableInteractiveSelection: false,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(40),
                                  ],
                                  controller: controller.searchArtistController,
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                      hintText: 'Search here..'.tr,
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true),
                                  onChanged: (value) {
                                    controller.getSearchArtistList(value);
                                  }),
                            ),
                            Obx(
                              () => Visibility(
                                  visible: controller.searchArtistText.isEmpty
                                      ? false
                                      : true,
                                  child: Image.asset(
                                    Assets.cross,
                                    height: 15,
                                    width: 10,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 450, // Set your maximum height value
                        ),
                        child: Container(
                          // height: 450,
                          padding: const EdgeInsets.only(right: 20, top: 0),
                          child: Obx(() => controller.isArtistSearch.value
                              ? artistSearchListWidget()
                              : artistListWidget()),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }), isScrollControlled: true);
  }

  artistListWidget() {
    return Obx(
      () => controller.firstTimeScreen.value
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator())
          : controller.allArtistList.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.allArtistList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        controller.nameController.text = controller
                            .allArtistList[index].workerName
                            .toString();
                        controller.artistName.value = controller
                            .allArtistList[index].workerName
                            .toString();
                        controller.artistId.value =
                            controller.allArtistList[index].workerId.toString();
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.only(
                              top: 5, left: 15, bottom: 0, right: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    // child: Image.network(
                                    //   controller.allServiceList[index].salonPicture
                                    //       .toString(),
                                    //   height: 50,
                                    //   width: 50,
                                    // ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: SizedBox(
                                      width: 55.w,
                                      child: Text(
                                        controller
                                            .allArtistList[index].workerName
                                            .toString(),
                                        maxLines: 3,
                                        style: AppStyles.textStyle(
                                          weight: FontWeight.w500,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ).marginOnly(left: 10),
                                  const Spacer(),
                                  const Icon(Icons.navigate_next),
                                ],
                              ),
                              const Divider().marginOnly(top: 5, bottom: 0),
                            ],
                          )),
                    );
                  })
              : Center(
                  child: NoDataScreen(
                    title: "no_country_available".tr,
                  ),
                ),
    );
  }

  artistSearchListWidget() {
    return controller.searchArtistList.isNotEmpty
        ? ListView.builder(
            itemCount: controller.searchArtistList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  controller.nameController.text =
                      controller.searchArtistList[index].workerName.toString();
                  controller.artistName.value =
                      controller.searchArtistList[index].workerName.toString();
                  controller.artistId.value =
                      controller.searchArtistList[index].workerId.toString();
                  Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.only(
                        top: 5, left: 15, bottom: 0, right: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              // child: Image.network(
                              //   controller.searchServiceList[index].salonPicture
                              //       .toString(),
                              //   height: 50,
                              //   width: 50,
                              // ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: SizedBox(
                                width: 55.w,
                                child: Text(
                                  controller.searchArtistList[index].workerName
                                      .toString(),
                                  maxLines: 3,
                                  style: AppStyles.textStyle(
                                    weight: FontWeight.w500,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ).marginOnly(left: 10),
                            const Spacer(),
                            const Icon(Icons.navigate_next),
                          ],
                        ),
                        const Divider().marginOnly(top: 5, bottom: 0),
                      ],
                    )),
              );
            })
        : Center(
            child: NoDataScreen(
            title: "no_country_available".tr,
          ));
  }
}
