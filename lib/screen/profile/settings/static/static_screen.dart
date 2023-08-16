import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/screen/profile/settings/setting_controller.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/res_dimens.dart';

import 'static_controller.dart';

class StaticScreen extends GetView<StaticController> {
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
            // title: Text("setting".tr,
            //     style: AppStyles.textStyle(
            //         fontSize: dimen18, weight: FontWeight.w600)),
            title: Text(controller.title.value,
                style: AppStyles.textStyle(
                    fontSize: dimen18, weight: FontWeight.normal)),
            automaticallyImplyLeading: false,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top:50),
          child: Text(
              "Your privacy is important to us. It is Brainstorming's policy to respect your privacy regarding any information we may collect from you across our app, and other sites we own and operate.",
textAlign: TextAlign.justify,
              style: AppStyles.textStyle(
                  fontSize: dimen13, weight: FontWeight.normal)


          ),
        ));
  }
}
