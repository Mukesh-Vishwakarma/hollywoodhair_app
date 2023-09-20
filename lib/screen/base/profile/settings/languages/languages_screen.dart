import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/res_dimens.dart';

import 'languages_controller.dart';

class LanguageScreen extends GetView<LanguagesController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: AppColors.colorFF,
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                )),
            title: Text("languages".tr,
                style: AppStyles.textStyle(
                    fontSize: dimen15, weight: FontWeight.normal)),
            automaticallyImplyLeading: false,
          ),
        ),
        body: Obx(
          () => Column(
            children: [
              const SizedBox(height: 30),
              ListView.builder(
                // scrollDirection: Axis.vertical,
                shrinkWrap: true,
                reverse: false,
                itemCount: controller.languageList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return language(index);
                },
              ),
            ],
          ),
        ));
  }

  language(index) {
    return GestureDetector(
      onTap: () {
        controller.changeLanguage(controller.languageList[index]);
      },
      child: Obx(() => Container(
            // height: 100,
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
            width: Get.size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.selectLang.value.name == controller.languageList[index].name
                    ? AppColors.color7C
                    : AppColors.black,
                // style: BorderStyle.solid,
                width: 1.0,
              ),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  controller.languageList[index].name.toString(),
                  style: AppStyles.textStyle(
                    color: controller.selectLang.value.name == controller.languageList[index].name
                        ? AppColors.color7C
                        : AppColors.black,
                    fontSize: dimen12,
                    weight: FontWeight.normal,
                  ),
                )),
                controller.selectLang.value.name ==
                        controller.languageList[index].name
                    ? Image.asset(Assets.click)
                    : const SizedBox()
              ],
            ),
          )),
    );
  }
}
