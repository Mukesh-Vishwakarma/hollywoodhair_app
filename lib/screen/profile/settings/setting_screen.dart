import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';

import 'setting_controller.dart';

class SettingScreen extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: AppColors.colorFF,
          leading:GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back,color: AppColors.black,)),
          // title: Text("setting".tr,
          //     style: AppStyles.textStyle(
          //         fontSize: dimen18, weight: FontWeight.w600)),
          title: Text("setting".tr,
              style: AppStyles.textStyle(
                  fontSize: dimen18, weight: FontWeight.normal)),
          automaticallyImplyLeading: false,
        ),
      ),


      body: SingleChildScrollView(child: Column(children: [

        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: (){
            Get.toNamed(AppPages.changePasswordScreen);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              children: [

                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("change_password".tr,
                      style: AppStyles.textStyle(
                        fontSize: dimen15, weight: FontWeight.w400,)

                  ),
                )),


                Padding(
                  padding: const EdgeInsets.only(right: 20,top: 10),
                  child: Image.asset(Assets.arrowLeft,height: 30,width: 30,),
                ),
              ],
            ),
          ),
        ),




        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Divider(),
        ),
        GestureDetector(
          onTap: (){
            Get.toNamed(AppPages.languagesScreen);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              children: [

                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("languages".tr,
                      style: AppStyles.textStyle(
                        fontSize: dimen15, weight: FontWeight.w400,)

                  ),
                )),


                Padding(
                  padding: const EdgeInsets.only(right: 20,top: 10),
                  child: Image.asset(Assets.arrowLeft,height: 30,width: 30,),
                ),
              ],
            ),
          ),
        ),




        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Divider(),
        ),
        GestureDetector(
          onTap: (){
            Get.toNamed(AppPages.staticScreen,arguments:"terms_&_condition".tr );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              children: [

                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("terms_&_condition".tr,
                      style: AppStyles.textStyle(
                        fontSize: dimen15, weight: FontWeight.w400,)

                  ),
                )),


                Padding(
                  padding: const EdgeInsets.only(right: 20,top: 10),
                  child: Image.asset(Assets.arrowLeft,height: 30,width: 30,),
                ),
              ],
            ),
          ),
        ),



        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Divider(),
        ),
        GestureDetector(
          onTap: (){
            Get.toNamed(AppPages.staticScreen,arguments:"privacy_policy".tr);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              children: [

                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("privacy_policy".tr,
                      style: AppStyles.textStyle(
                        fontSize: dimen15, weight: FontWeight.w400,)

                  ),
                )),


                Padding(
                  padding: const EdgeInsets.only(right: 20,top: 10),
                  child: Image.asset(Assets.arrowLeft,height: 30,width: 30,),
                ),
              ],
            ),
          ),
        ),



        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Divider(),
        ),
        GestureDetector(
          onTap: (){
            Get.toNamed(AppPages.contactScreen);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              children: [

                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("contact_us".tr,
                      style: AppStyles.textStyle(
                        fontSize: dimen15, weight: FontWeight.w400,)

                  ),
                )),


                Padding(
                  padding: const EdgeInsets.only(right: 20,top: 10),
                  child: Image.asset(Assets.arrowLeft,height: 30,width: 30,),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Divider(),
        ),
        GestureDetector(

          onTap: (){
            Get.toNamed(AppPages.faqScreen);
          },

          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              children: [

                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("FAQs".tr,
                      style: AppStyles.textStyle(
                        fontSize: dimen15, weight: FontWeight.w400,)

                  ),
                )),


                Padding(
                  padding: const EdgeInsets.only(right: 20,top: 10),
                  child: Image.asset(Assets.arrowLeft,height: 30,width: 30,),
                ),
              ],
            ),
          ),
        ),
      ],),),



    );
  }
}
