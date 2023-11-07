import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/no_data.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../util/common_function.dart';
import 'static_controller.dart';

class StaticScreen extends GetView<StaticController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: AppColors.colorFF,
          titleSpacing: 0,
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
          title: Text(controller.title.value,
              style: AppStyles.textStyle(
                  fontSize: 18.0, weight: FontWeight.normal)),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Obx(() => !controller.isPageLoad.value
          ? controller.appContentTextHtml.value.isEmpty
              ? Center(
                  child: NoDataScreen(
                    title: "No Data Found",
                  ),
                )
              : SingleChildScrollView(
        physics: BouncingScrollPhysics(),
                child: Html(
                    data: controller.appContentTextHtml.value.toString(),
                  ).marginOnly(top: 10, left: 15, right: 15),
              )
          : shimmerDemo()),
    );
  }
}
