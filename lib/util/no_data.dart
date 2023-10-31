import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';

import 'res_dimens.dart';

class NoDataScreen extends StatelessWidget {
  String? title;
  String? description;
  String? image;
  double? height;
  double? width;

  NoDataScreen(
      {this.title, this.image, this.description, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              (image != null) ? image.toString() : Assets.nothingSearch,
              height: height ?? 80,
              width: width ?? 80,
              // fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Text(title ?? 'data_not_available'.tr,
                textAlign: TextAlign.center,
                style: AppStyles.textStyle(
                  fontSize: title == "Nothing Searched Yet" ? dimen15 : dimen20,
                  weight: FontWeight.w500,
                )),
          ),
          Center(
            child: Text(description ?? '',
                textAlign: TextAlign.center,
                style: AppStyles.textStyle(
                    fontSize: dimen15,
                    weight: FontWeight.w400,
                    color: AppColors.gray9E)),
          )
        ],
      ),
    );
  }
}
