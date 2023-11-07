import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../util/no_data.dart';
import '../../../../util/theme_service.dart';
import 'booking_form_controller.dart';

class BookingFormScreen extends GetView<BookingFormController> {
  const BookingFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: AppBar(
          elevation: 0.8,
          titleSpacing: 0,
          backgroundColor: AppColors.colorFF,
          leading: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // Set the same rounded border as Material
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
        child: Column(
          children: [
            Form(
                key: controller.formLoginKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),

                      //****** name

                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("name".tr,
                            style: AppStyles.textStyle(
                                fontSize: 14.0, weight: FontWeight.normal)),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: textFieldWithoutLabel(
                          controller: controller.nameController,
                          validationMsg: "plz_enter_name".tr,
                          text: controller.name,
                          hintText: 'name'.tr,
                          type: "name",
                          label: true,
                        ),
                      ),

                      //****** phone number
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("phone_number".tr,
                            style: AppStyles.textStyle(
                                fontSize: 14.0, weight: FontWeight.normal)),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: contactNumberWithoutCountry(
                            controller: controller.phoneNumberController,
                            validationMsg: "phone_number".tr,
                            text: controller.phoneNumber,
                            hintText: 'phone_number'.tr,
                            code: "+91",
                            context: context
                            // type: "phone number",
                            // label: true,
                            ),
                      ),

                      //****** age
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("age".tr,
                            style: AppStyles.textStyle(
                                fontSize: 14.0, weight: FontWeight.normal)),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: numberTextFields(
                            controller: controller.ageController,
                            validationMsg: "age".tr,
                            text: controller.ageController,
                            hintText: 'age'.tr,
                            lengthLimit: 2
                            // type: "name",
                            // label: true,
                          )),

                      //****** gender
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("gender".tr,
                            style: AppStyles.textStyle(
                                fontSize: 14.0, weight: FontWeight.normal)),
                      ),
                      Container(
                        width: 100.w,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        color:AppColors.dividerColorNew,
                        child: TextFormField(
                          controller: controller.genderController,
                          style: const TextStyle(
                            color: AppColors.black84
                          ),
                          readOnly: true,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "gender".tr;
                            }
                            return null;
                          },
                          // onTap: () {
                          //   genderBottomSheet();
                          // },
                          decoration: InputDecoration(
                            fillColor: Colors.red,
                            isDense: false,
                            contentPadding: const EdgeInsets.all(15),
                            hintText: "gender".tr,
                            hintStyle: AppStyles.textStyle(
                              color: AppColors.searchHintColor,
                              fontSize: 14.0,
                              weight: FontWeight.normal,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                Assets.dropDown,
                              ),
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
                        ),
                      ),
                      //****** service
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("service".tr,
                            style: AppStyles.textStyle(
                                fontSize: 14.0, weight: FontWeight.normal)),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: TextFormField(
                            controller: controller.serviceController,
                            readOnly: true,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "service".tr;
                              }
                              return null;
                            },
                            onTap: () {
                              servicePickerBottomSheet();
                            },
                            decoration: InputDecoration(
                              isDense: false,
                              contentPadding: const EdgeInsets.all(15),
                              hintText: "service".tr,
                              hintStyle: AppStyles.textStyle(
                                color: AppColors.searchHintColor,
                                fontSize: 14.0,
                                weight: FontWeight.normal,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  Assets.dropDown,
                                ),
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

                      //****** service
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("show_room_location".tr,
                            style: AppStyles.textStyle(
                                fontSize: 14.0, weight: FontWeight.normal)),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: TextFormField(
                            controller: controller.saloonLocationController,
                            readOnly: true,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "show_room_location".tr;
                              }
                              return null;
                            },
                            onTap: () {
                              saloonPickerBottomSheet();
                            },
                            decoration: InputDecoration(
                              isDense: false,
                              contentPadding: const EdgeInsets.all(15),
                              hintText: "show_room_location".tr,
                              hintStyle: AppStyles.textStyle(
                                color: AppColors.searchHintColor,
                                fontSize: 14.0,
                                weight: FontWeight.normal,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  Assets.dropDown,
                                ),
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
                    ])),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  if (!controller.formLoginKey.currentState!.validate()) {
                    print("not validate");
                  } else {
                    if(int.parse(controller.ageController.text.toString().trim()) > 10) {
                      Get.toNamed(
                        AppPages.bookingAppointmentScreen,
                        arguments: {
                          'name': controller.nameController.text.trim(),
                          'phone_number': controller.phoneNumberController.text
                              .trim(),
                          'age': controller.ageController.text.trim(),
                          'gender': controller.genderController.text.trim(),
                          'service': controller.serviceController.text.trim(),
                          'serviceId': controller.serviceId.toString(),
                          'saloon_address': controller.saloonLocationController
                              .text.trim(),
                          'saloonId': controller.saloonLocationId.trim(),
                        },
                      );
                    } else {
                      successToastDynamic("Please enter a valid date.",AppColors.black);
                    }
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 80, bottom: 10),
                    child: buttom("next".tr))),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  /// Saloon list bottom sheet
  saloonPickerBottomSheet() {
    Get.bottomSheet(
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(0)),
              padding:
                  const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 20),
              child: Wrap(children: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 12),
                                        child: Icon(Icons.search_rounded,
                                            size: 25, color: textThemeColor()),
                                      ),
                                      Expanded(
                                        child: TextField(
                                            enableInteractiveSelection: false,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  40),
                                            ],
                                            controller: controller
                                                .searchSaloonController,
                                            autocorrect: true,
                                            decoration: InputDecoration(
                                                hintText: 'Search here..'.tr,
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.zero,
                                                isDense: true),
                                            onChanged: (value) {
                                              controller
                                                  .getSearchSaloonList(value);
                                            }),
                                      ),
                                      Obx(
                                        () => Visibility(
                                            visible:
                                                controller.searchText.isEmpty
                                                    ? false
                                                    : true,
                                            child: Image.asset(
                                              Assets.cross,
                                              height: 15,
                                              width: 10,
                                            )),
                                      ),
                                    ])),
                            Container(
                              height: 450,
                              padding: const EdgeInsets.only(right: 20, top: 0),
                              child: Obx(() => controller.isSearch.value
                                  ? searchSaloonListWidget()
                                  : saloonListWidget()),
                            )
                          ]),
                    ))
              ])));
    }), isScrollControlled: true);
  }

  saloonListWidget() {
    return Obx(() => controller.firstTimeScreen.value
        ? Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator())
        : controller.allSaloonList.isNotEmpty
            ? ListView.builder(
                itemCount: controller.allSaloonList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      controller.saloonLocationController.text = controller
                          .allSaloonList[index].salonAddress
                          .toString();
                      controller.saloonLocationId.value =
                          controller.allSaloonList[index].salonId.toString();
                      print("kzkkkxc==>${controller.saloonLocationId.value}");
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
                                  child: Image.network(
                                    controller.allSaloonList[index].salonPicture
                                        .toString(),
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: SizedBox(
                                    width: 55.w,
                                    child: Text(
                                      controller
                                          .allSaloonList[index].salonAddress
                                          .toString(),
                                      maxLines: 3,
                                      style: AppStyles.textStyle(
                                        weight: FontWeight.w500,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ).marginOnly(left: 10)
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
              )));
  }

  searchSaloonListWidget() {
    return controller.searchSaloonList.isNotEmpty
        ? ListView.builder(
            itemCount: controller.searchSaloonList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  controller.saloonLocationController.text = controller
                      .searchSaloonList[index].salonAddress
                      .toString();
                  controller.saloonLocationId.value = controller.searchSaloonList[index].salonId.toString();

                  print("kzkkkxc==>${controller.saloonLocationId.value}");
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
                              child: Image.network(
                                controller.searchSaloonList[index].salonPicture
                                    .toString(),
                                height: 50,
                                width: 50,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: SizedBox(
                                width: 55.w,
                                child: Text(
                                  controller
                                      .searchSaloonList[index].salonAddress
                                      .toString(),
                                  maxLines: 3,
                                  style: AppStyles.textStyle(
                                    weight: FontWeight.w500,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ).marginOnly(left: 10)
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

  ///  Services list bottom sheet
  servicePickerBottomSheet() {
    Get.bottomSheet(
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(0)),
              padding:
                  const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 20),
              child: Wrap(children: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 12),
                                        child: Icon(Icons.search_rounded,
                                            size: 25, color: textThemeColor()),
                                      ),
                                      Expanded(
                                        child: TextField(
                                            enableInteractiveSelection: false,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  40),
                                            ],
                                            controller: controller
                                                .searchServiceController,
                                            autocorrect: true,
                                            decoration: InputDecoration(
                                                hintText: 'Search here..'.tr,
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.zero,
                                                isDense: true),
                                            onChanged: (value) {
                                              controller
                                                  .getSearchServicesList(value);
                                            }),
                                      ),
                                      Obx(
                                        () => Visibility(
                                            visible: controller
                                                    .searchServiceText.isEmpty
                                                ? false
                                                : true,
                                            child: Image.asset(
                                              Assets.cross,
                                              height: 15,
                                              width: 10,
                                            )),
                                      ),
                                    ])),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 450, // Set your maximum height value
                              ),
                              child: Container(
                                // height: 450,
                                padding:
                                    const EdgeInsets.only(right: 20, top: 0),
                                child: Obx(() =>
                                    controller.isServiceSearch.value
                                        ? serviceSearchListWidget()
                                        : serviceListWidget()),
                              ),
                            )
                          ]),
                    ))
              ])));
    }), isScrollControlled: true);
  }

  serviceListWidget() {
    return Obx(() => controller.firstTimeScreen.value
        ? Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator())
        : controller.allServiceList.isNotEmpty
            ? ListView.builder(
                itemCount: controller.allServiceList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      controller.serviceController.text = controller
                          .allServiceList[index].serviceName
                          .toString();
                      controller.serviceId.value =
                          controller.allServiceList[index].serviceId.toString();
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
                                          .allServiceList[index].serviceName
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
              )));
  }

  serviceSearchListWidget() {
    return controller.searchServiceList.isNotEmpty
        ? ListView.builder(
            itemCount: controller.searchServiceList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  controller.serviceController.text = controller
                      .searchServiceList[index].serviceName
                      .toString();
                  controller.serviceId.value =
                      controller.searchServiceList[index].serviceId.toString();
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
                                  controller
                                      .searchServiceList[index].serviceName
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

  ///  Gender
  genderBottomSheet() {
    return Get.bottomSheet(
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(0)),
              padding:
                  const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 20),
              child: Wrap(children: [
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
                        padding: const EdgeInsets.only(
                            left: 15, top: 20, bottom: 40, right: 15),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.genderList.value.length,
                            itemBuilder: (BuildContext context, index) {
                              return ListTile(
                                onTap: () {
                                  controller.checkGender.value = false;
                                  controller.genderController.text = controller
                                      .genderList.value[index]
                                      .toString();
                                  // controller.isGender.value = controller.genderList.value[index].toString();
                                  controller.gender.value = controller
                                      .genderList.value[index]
                                      .toString();
                                  print(
                                      "Gender>>>>>${controller.gender.value}");
                                  Navigator.pop(context);
                                },
                                leading: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 10, top: 10),
                                  child: Text(
                                    controller.genderList.value[index]
                                        .toString(),
                                    style: AppStyles.textStyle(
                                      fontSize: 15.0,
                                      color: textThemeColor(),
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                trailing: controller.gender.value ==
                                        controller.genderList.value[index]
                                            .toString()
                                    ? Image.asset(
                                        Assets.imagesSelected,
                                        height: 20,
                                        width: 20,
                                      )
                                    : SvgPicture.asset(
                                        Assets.imagesUnselect,
                                        height: 20,
                                        width: 20,
                                      ),
                              );
                            }))),
              ])));
    }), isScrollControlled: true);
  }
}
