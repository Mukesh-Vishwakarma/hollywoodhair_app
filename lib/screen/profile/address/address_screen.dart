import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/res_dimens.dart';

import 'address_controller.dart';

class AddressScreen extends GetView<AddressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
    child: AppBar(
    backgroundColor: AppColors.colorFF,
    leading: GestureDetector(
    onTap: () {
    Get.back();
    },
    child: Icon(
    Icons.arrow_back,
    color: AppColors.black,
    )),
    title: Text("contact_us".tr,
    style: AppStyles.textStyle(
    fontSize: dimen15, weight: FontWeight.normal)),
    automaticallyImplyLeading: false,
    ),
    ),);}}