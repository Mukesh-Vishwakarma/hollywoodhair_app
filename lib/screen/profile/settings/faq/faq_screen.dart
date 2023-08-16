import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/res_dimens.dart';

import 'faq_controller.dart';

class FaqScreen extends GetView<FaqController> {
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
          title: Text('FAQs'.tr,
              style: AppStyles.textStyle(
                  fontSize: dimen18, weight: FontWeight.normal)),
          automaticallyImplyLeading: false,
        ),
      ),
        body:Column(children: [

          Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 20, top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,

              child: Theme(
                  data: Theme.of(context).copyWith(
                      dividerColor: Colors.grey),
                  child: ExpansionTile(
                      onExpansionChanged: ((newState) {
                        debugPrint("newState");

                        if (newState) {
                          // controller.changeColor.value = index;
                        } else {
                          // controller.changeColor.value = -1;
                        }

                      }),
                      title: Text(
                          "Q.  "+'How do I book an appointment using the salon app?',
                          style: AppStyles.textStyle(
                            color: AppColors.black,
                            fontSize: dimen10,
                          )
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 20),
                          child: Text(
                           "Booking an appointment through our salon app is simple and convenient. Follow these steps to schedule your visit- Select Your Services Choose a Date and Time Select a Salon Professional Confirm Your Booking",
                            style: TextStyle(
                                fontSize: dimen10,
                                height: 1.4), // style:AppStyles.textStyle(
                          ),
                        ),
                      ]))),

          Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 20, top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,

              child: Theme(
                  data: Theme.of(context).copyWith(
                      dividerColor: Colors.grey),
                  child: ExpansionTile(
                      onExpansionChanged: ((newState) {
                        debugPrint("newState");

                        if (newState) {
                          // controller.changeColor.value = index;
                        } else {
                          // controller.changeColor.value = -1;
                        }

                      }),
                      title: Text(
                          "Q.  "+'How do I book an appointment using the salon app?',
                          style: AppStyles.textStyle(
                            color: AppColors.black,
                            fontSize: dimen10,
                          )
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 20),
                          child: Text(
                            "Booking an appointment through our salon app is simple and convenient. Follow these steps to schedule your visit- Select Your Services Choose a Date and Time Select a Salon Professional Confirm Your Booking",
                            style: TextStyle(
                                fontSize: dimen10,
                                height: 1.4), // style:AppStyles.textStyle(
                          ),
                        ),
                      ]))),




          Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 20, top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,

              child: Theme(
                  data: Theme.of(context).copyWith(
                      dividerColor: Colors.grey),
                  child: ExpansionTile(
                      onExpansionChanged: ((newState) {
                        debugPrint("newState");

                        if (newState) {
                          // controller.changeColor.value = index;
                        } else {
                          // controller.changeColor.value = -1;
                        }

                      }),
                      title: Text(
                          "Q.  "+'How do I book an appointment using the salon app?',
                          style: AppStyles.textStyle(
                            color: AppColors.black,
                            fontSize: dimen10,
                          )
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 20),
                          child: Text(
                            "Booking an appointment through our salon app is simple and convenient. Follow these steps to schedule your visit- Select Your Services Choose a Date and Time Select a Salon Professional Confirm Your Booking",
                            style: TextStyle(
                                fontSize: dimen10,
                                height: 1.4), // style:AppStyles.textStyle(
                          ),
                        ),
                      ]))),


          Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 20, top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,

              child: Theme(
                  data: Theme.of(context).copyWith(
                      dividerColor: Colors.grey),
                  child: ExpansionTile(
                      onExpansionChanged: ((newState) {
                        debugPrint("newState");

                        if (newState) {
                          // controller.changeColor.value = index;
                        } else {
                          // controller.changeColor.value = -1;
                        }

                      }),
                      title: Text(
                          "Q.  "+'How do I book an appointment using the salon app?',
                          style: AppStyles.textStyle(
                            color: AppColors.black,
                            fontSize: dimen10,
                          )
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 20),
                          child: Text(
                            "Booking an appointment through our salon app is simple and convenient. Follow these steps to schedule your visit- Select Your Services Choose a Date and Time Select a Salon Professional Confirm Your Booking",
                            style: TextStyle(
                                fontSize: dimen10,
                                height: 1.4), // style:AppStyles.textStyle(
                          ),
                        ),
                      ]))),
        ],)




    );
  }
}
