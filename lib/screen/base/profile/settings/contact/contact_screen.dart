import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/res_dimens.dart';

import 'contact_controller.dart';

class ContactScreen extends GetView<ContactController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
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
          title: Text("contact_us".tr,
              style: AppStyles.textStyle(
                  fontSize: dimen14, weight: FontWeight.normal)),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  Assets.msg,
                  height: 25,
                  width: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'support@hollywoodhair.com',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize:dimen12,
                      fontFamily: 'TT Firs Neue Trl',
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      height: 1.43,
                    ),
                  ),
                )
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  Assets.phone,
                  height: 25,
                  width: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    '+48 12349 34823',
                      style: AppStyles.textStyle(
                          fontSize: dimen12, weight: FontWeight.normal)
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
