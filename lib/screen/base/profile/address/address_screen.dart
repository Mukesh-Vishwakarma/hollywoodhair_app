import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/src/shopify_user/address/address.dart';

import 'address_controller.dart';

class AddressScreen extends GetView<AddressController> {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: AppColors.colorFF,
          titleSpacing: 0,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.black,
              )),
          title: Text("select_address".tr,
              style: AppStyles.textStyle(
                  fontSize: dimen15, weight: FontWeight.normal)),
          automaticallyImplyLeading: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => !controller.isPageLoad.value
                ? controller.noData.isTrue
                    ? Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: GestureDetector(
                          onTap: () {
                            controller.clearTextFiled();
                            addAddress(type: 'add');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Image.asset(
                                  Assets.add,
                                  height: 15,
                                  width: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Add New Address",
                                  style: AppStyles.textStyle(
                                    color: AppColors.black,
                                    fontSize: dimen12,
                                    weight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        // scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        reverse: false,
                        itemCount: controller.addresses!.addressList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return getAddress(
                              controller.addresses!.addressList[index]);
                        })
                : shimmerDemo()),
            Obx(() => controller.noData.isTrue
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const DottedLine(
                        dashColor: AppColors.gray99,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          // controller.clearTextFiled();
                          addAddress(type: 'add');
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Image.asset(
                                Assets.add,
                                height: 15,
                                width: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Add New Address",
                                style: AppStyles.textStyle(
                                  color: AppColors.black,
                                  fontSize: dimen12,
                                  weight: FontWeight.normal,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
          ],
        ),
      ),
    );
  }

  getAddress(Address address) {
    return GestureDetector(
      onTap: () {
        // controller.checkAddress.value = index;
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                // controller.checkAddress.value == index ? AppColors.color7C :
                AppColors.black,
            // style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                Assets.house,
                height: 30,
                width: 30,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    address.company != null
                        ? Text(
                            address.company ?? "",
                            style: AppStyles.textStyle(
                              color:
                                  // controller.checkAddress.value == index
                                  //     ? AppColors.color7C :
                                  AppColors.black,
                              fontSize: dimen12,
                              weight: FontWeight.w400,
                            ),
                          )
                        : SizedBox(),
                    Text(
                      address.name.toString(),
                      style: AppStyles.textStyle(
                        color: AppColors.black,
                        fontSize: dimen12,
                        weight: FontWeight.w400,
                      ),
                    ),
                    address.phone != null
                        ? Text(
                            address.phone ?? "",
                            style: AppStyles.textStyle(
                              color: AppColors.black,
                              fontSize: dimen12,
                              weight: FontWeight.normal,
                            ),
                          )
                        : SizedBox(),
                    controller.email != null
                        ? Text(
                            controller.email,
                            style: AppStyles.textStyle(
                              color: AppColors.black,
                              fontSize: dimen12,
                              weight: FontWeight.normal,
                            ),
                          )
                        : SizedBox(),
                    address.address1 != null
                        ? Text(address.address1 ?? "",
                            style: AppStyles.textStyle(
                              color: AppColors.black,
                              fontSize: dimen12,
                            ))
                        : SizedBox(),
                    Row(
                      children: [
                        address.city != null
                            ? Text(
                                "${address.city}",
                                style: AppStyles.textStyle(
                                  color: AppColors.black,
                                  fontSize: dimen12,
                                ),
                              )
                            : SizedBox(),
                        address.countryCode != null
                            ? Text(
                                ", ${address.countryCode} ",
                                style: AppStyles.textStyle(
                                  color: AppColors.black,
                                  fontSize: dimen12,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    Row(
                      children: [
                        address.country != null
                            ? Text(
                                address.country.toString(),
                                style: AppStyles.textStyle(
                                  color: AppColors.black,
                                  fontSize: dimen12,
                                ),
                              )
                            : SizedBox(),
                        address.zip != null
                            ? Text(
                                "  ${address.zip}",
                                style: AppStyles.textStyle(
                                  color: AppColors.black,
                                  fontSize: dimen12,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.clearTextFiled();
                addAddress(type: 'edit', address: address);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  Assets.edit,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.deleteAddresses(address.id);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  Assets.delete,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addAddress({type, address}) {
    if (type == 'edit') {
      controller.address1Controller.text = address!.address1.toString();
      controller.address2Controller.text = address.address2.toString();
      controller.firstNameController.text = address.firstName.toString();
      controller.lastNameController.text = address.lastName.toString();
      controller.cityController.text = address.city.toString();
      controller.countryController.text = address.country.toString();
      controller.companyController.text = address.company.toString();
      controller.zipCodeController.text = address.zip.toString();
      controller.phoneNumberController.text = address.phone.toString();
    }
    return Get.bottomSheet(
        Container(
            margin: EdgeInsets.only(bottom: 0),
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 8, bottom: 0),
                      child: Image.asset(
                        Assets.imagesIcLine,
                        height: 36,
                        width: 36,
                        // color: Colors.grey,
                      ),
                    ),
                    Container(
                        width: Get.size.width,
                        decoration: BoxDecoration(
                            color: AppColors.lightBackgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(40.0),
                                topRight: const Radius.circular(40.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Text(type == "add" ? "Add address" : 'Edit address',
                                style: AppStyles.textStyle(
                                  color: AppColors.black,
                                  fontSize: dimen12,
                                  weight: FontWeight.w500,
                                )),
                            Form(
                                key: controller.formLoginKey,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 20,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textField2(
                                          hintText: "First Name",
                                          validationMsg:
                                              "Please enter first name",
                                          controller:
                                              controller.firstNameController,
                                        ),
                                        const SizedBox(height: 20.0),
                                        textField2(
                                          hintText: "Last Name",
                                          validationMsg:
                                              "Please enter last name",
                                          controller:
                                              controller.lastNameController,
                                        ),
                                        const SizedBox(height: 20.0),
                                        textField2(
                                          hintText: "Conpany",
                                          validationMsg: "Please enter company",
                                          controller:
                                              controller.companyController,
                                        ),
                                        const SizedBox(height: 20.0),
                                        textField2(
                                          hintText: "Address 1",
                                          validationMsg:
                                              "Please enter Address 1",
                                          controller:
                                              controller.address1Controller,
                                        ),
                                        const SizedBox(height: 20.0),
                                        textField2(
                                          hintText: "Address 2",
                                          validationMsg:
                                              "Please enter Address 2",
                                          controller:
                                              controller.address2Controller,
                                        ),
                                        const SizedBox(height: 20.0),
                                        textField2(
                                          hintText: "City",
                                          validationMsg: "Please enter City",
                                          controller: controller.cityController,
                                        ),
                                        const SizedBox(height: 20.0),
                                        textField2(
                                          hintText: "Country",
                                          validationMsg: "Please enter country",
                                          controller:
                                              controller.countryController,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 20, top: 20),
                                                  child: TextFormField(
                                                    controller: controller
                                                        .cityController,
                                                    style: AppStyles.textStyle(
                                                      fontSize: dimen12,
                                                      weight: FontWeight.normal,
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'City'.tr;
                                                      }

                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      isDense: false,
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              15),

                                                      hintText: 'City'.tr,
                                                      hintStyle:
                                                          AppStyles.textStyle(
                                                        color: AppColors.black,
                                                        fontSize: dimen12,
                                                        weight:
                                                            FontWeight.normal,
                                                      ),

                                                      labelText: 'City'.tr,
                                                      labelStyle:
                                                          AppStyles.textStyle(
                                                        color: AppColors.black,
                                                        fontSize: dimen12,
                                                        weight:
                                                            FontWeight.normal,
                                                      ),

                                                      // const TextStyle(
                                                      //     color: AppColors.color3D,
                                                      //     fontSize: 14,
                                                      //     fontWeight: FontWeight.w400),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColors
                                                                    .colorCD,
                                                                width: 0.99),
                                                      ),
                                                      errorBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      focusedErrorBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8)),
                                                        borderSide: BorderSide(
                                                          color: Colors.red,
                                                        ),
                                                      ),

                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColors
                                                                    .colorCD,
                                                                width: 0.99),
                                                      ),

                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.grey,
                                                          width: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 20, top: 20),
                                                child: TextFormField(
                                                  controller: controller
                                                      .zipCodeController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: AppStyles.textStyle(
                                                    fontSize: dimen12,
                                                    weight: FontWeight.normal,
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'zip_code'.tr;
                                                    }

                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    isDense: false,
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            15),

                                                    hintText: 'zip_code'.tr,
                                                    hintStyle:
                                                        AppStyles.textStyle(
                                                      color: AppColors.black,
                                                      fontSize: dimen12,
                                                      weight: FontWeight.normal,
                                                    ),

                                                    labelText: 'zip_code'.tr,
                                                    labelStyle:
                                                        AppStyles.textStyle(
                                                      color: AppColors.black,
                                                      fontSize: dimen12,
                                                      weight: FontWeight.normal,
                                                    ),

                                                    // const TextStyle(
                                                    //     color: AppColors.color3D,
                                                    //     fontSize: 14,
                                                    //     fontWeight: FontWeight.w400),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: AppColors
                                                                  .colorCD,
                                                              width: 0.99),
                                                    ),
                                                    errorBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                      ),
                                                    ),

                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: AppColors
                                                                  .colorCD,
                                                              width: 0.99),
                                                    ),

                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.grey,
                                                        width: 0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20.0),
                                        textField2(
                                            controller: controller
                                                .phoneNumberController,
                                            validationMsg:
                                                "Please enter phone Number",
                                            hintText: "Phone Number"),
                                        Obx(() => controller.isPageLoad.isFalse
                                            ? GestureDetector(
                                                onTap: () {
                                                  if (type == "add") {
                                                    if (controller.formLoginKey
                                                        .currentState!
                                                        .validate()) {
                                                      controller
                                                          .createAddresses();
                                                    }
                                                  } else {
                                                    controller.updateAddresses(
                                                        id: address.id);
                                                  }
                                                },
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        top: 20,
                                                        bottom: 40),
                                                    child: buttom(type == "add"
                                                        ? "add_new_address".tr
                                                        : "Edit address")))
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 80,
                                                    bottom: 40),
                                                child: Container(
                                                  width: Get.size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    color: AppColors.color7C,
                                                  ),
                                                  child: const Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 15, bottom: 15),
                                                      child: SpinKitThreeBounce(
                                                        color: Colors.white,
                                                        size: 20.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                      ]),
                                ))
                          ],
                        ))
                  ]),
            )),
        isScrollControlled: true);
  }

  shimmerDemo() {
    return Container(
      width: Get.size.width,
      height: Get.size.height,
      margin: EdgeInsets.only(left: 0, right: 0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          itemBuilder: (__, _) => Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                      ),
                      Container(
                        width: Get.size.width,
                        height: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 3,
        ),
      ),
    );
  }

  textField2({controller, validationMsg, hintText}) {
    return TextFormField(
      controller: controller,
      style: AppStyles.textStyle(
        fontSize: dimen12,
        weight: FontWeight.normal,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validationMsg;
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: false,
        contentPadding: const EdgeInsets.all(15),

        hintText: hintText,
        hintStyle: AppStyles.textStyle(
          color: AppColors.black,
          fontSize: dimen12,
          weight: FontWeight.normal,
        ),
        labelText: hintText,
        labelStyle: AppStyles.textStyle(
          color: AppColors.black,
          fontSize: dimen12,
          weight: FontWeight.normal,
        ),

        // const TextStyle(
        //     color: AppColors.color3D,
        //     fontSize: 14,
        //     fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.colorCD, width: 0.99),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.colorCD, width: 0.99),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 0,
          ),
        ),
      ),
    );
  }
}
