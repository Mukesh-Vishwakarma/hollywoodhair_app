import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:hollywood_hair/util/theme_service.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'app_colors.dart';
import 'app_constants.dart';
import 'app_style.dart';
import 'assets.dart';
import 'route/app_pages.dart';

textField({controller, validationMsg, text, hintText, type, label, readOnly}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly ?? false,
    style: AppStyles.textStyle(
      fontSize: 14.0,
      weight: FontWeight.normal,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return validationMsg;
      }

      if (type == "email") {
        if (!GetUtils.isEmail(value)) {
          return 'Invalid Email';
        }
      }
      return null;
    },
    onChanged: (value) {
      text = value;
    },
    decoration: InputDecoration(
      isDense: false,
      contentPadding: const EdgeInsets.all(15),
      hintText: hintText,
      hintStyle: AppStyles.textStyle(
        color: AppColors.searchHintColor,
        fontSize: 14.0,
        weight: FontWeight.normal,
      ),
      suffixIcon: type == "password"
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                Assets.seenPassword,
                height: 5,
              ),
            )
          : SizedBox(),
      labelText: (label) ? hintText : "",
      labelStyle: (label)
          ? AppStyles.textStyle(
              color: AppColors.black,
              fontSize: 14.0,
              weight: FontWeight.normal,
            )
          : null,
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

textFieldWithoutLabel(
    {controller, validationMsg, text, hintText, type, label, readOnly}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly ?? false,
    style: AppStyles.textStyle(
      fontSize: 14.0,
      weight: FontWeight.normal,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return validationMsg;
      }
      if (type == "email") {
        if (!GetUtils.isEmail(value)) {
          return 'Invalid Email';
        }
      }
      return null;
    },
    onChanged: (value) {
      text = value;
    },
    decoration: InputDecoration(
      isDense: false,
      contentPadding: const EdgeInsets.all(15),
      hintText: hintText,
      hintStyle: AppStyles.textStyle(
        color: AppColors.searchHintColor,
        fontSize: 14.0,
        weight: FontWeight.normal,
      ),
      suffixIcon: type == "password"
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                Assets.seenPassword,
                height: 5,
              ),
            )
          : const SizedBox(),
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

contactNumber({controller, validationMsg, text, hintText, code, context}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 24),
          // height: 46,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(12),
            ],
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter a phone number";
              } else if (!RegExp(
                      r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                  .hasMatch(value)) {
                return "Please enter a valid phone number";
              }
            },
            style: AppStyles.textStyle(
              fontSize: 14.0,
              weight: FontWeight.normal,
            ),
            onChanged: (value) {
              text = value;
            },
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                      exclude: <String>['KN', 'MF'],
                      favorite: <String>['SE'],
                      //Optional. Shows phone code before the country name.
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        print(
                            'Select country: ${country.phoneCode.toString()}');
                        code = country.phoneCode.toString();

                        print('Select code: ${code}');
                      },

                      // Optional. Sets the theme for the country list picker.
                      countryListTheme: CountryListThemeData(
                        // Optional. Sets the border radius for the bottomsheet.
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                        // Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                        // Optional. Styles the text in the search field
                        searchTextStyle: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          code.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: AppColors.black),
                        ),
                      ),
                      Image.asset(
                        Assets.dropDown,
                        height: 10,
                        width: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        height: 18,
                        width: 2,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.all(15),
              // hintText: "Enter Your Contact Number",
              // hintStyle: const TextStyle(
              //     fontSize: 13, fontWeight: FontWeight.w400),
              labelText: hintText,
              labelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.grayEB, width: 0.99),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.grayEB, width: 0.99),
              ),
              // errorBorder: const OutlineInputBorder(
              //   borderSide: BorderSide(color: Colors.red, width: 0.0),
              // ),
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
      ),
    ],
  );
}

contactNumberWithoutCountry(
    {controller, validationMsg, text, hintText, code, context}) {
  return Row(
    children: [
      Expanded(
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(12),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter a phone number";
            } else if (!RegExp(
                    r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                .hasMatch(value)) {
              return "Please enter a valid phone number";
            }
          },
          style: AppStyles.textStyle(
            fontSize: 14.0,
            weight: FontWeight.normal,
          ),
          onChanged: (value) {
            text = value;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            hintText: "Phone number",
            hintStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.searchHintColor,
            ),
            labelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: AppColors.colorCD, width: 0.99),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: AppColors.colorCD, width: 0.99),
            ),
            // errorBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.red, width: 0.0),
            // ),
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
    ],
  );
}

numberTextFields(
    {controller, validationMsg, text, hintText, code, context, lengthLimit}) {
  return Row(
    children: [
      Expanded(
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(lengthLimit ?? 12),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter $hintText";
            }
          },
          style: AppStyles.textStyle(
            fontSize: 14.0,
            weight: FontWeight.normal,
          ),
          onChanged: (value) {
            text = value;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            hintText: "$hintText",
            hintStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.searchHintColor,
            ),
            labelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: AppColors.colorCD, width: 0.99),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: AppColors.colorCD, width: 0.99),
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
    ],
  );
}

failedToast(msg) {
  defaultToast(msg, 'Error', AppColors.color1E);
}

defaultToast(String msg, String title, color) {
  Get.snackbar(
    title,
    msg,
    snackPosition: SnackPosition.BOTTOM,
    colorText: AppColors.lightBackgroundColor,
    messageText: Text(
      msg,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.all(20),
    isDismissible: false,
    snackStyle: SnackStyle.FLOATING,
  );
}

void isLogoutResponse() {
  Get.back();

  Future.delayed(const Duration(seconds: 2), () {
    GetStorage().remove(AppConstants.loginUser);
    GetStorage().remove(AppConstants.accessToken);
    GetStorage().remove(AppConstants.deviceToken);
    GetStorage().remove(AppConstants.deviceType);
    GetStorage().remove(AppConstants.isLogged);

    // progressDialog.dismiss();
    Get.offAllNamed(AppPages.signInScreen);
  });
}

buttom(text) {
  return Container(
    width: Get.size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      color: AppColors.color7C,
    ),
    child: Center(
      child: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Text(
          text,
          style: AppStyles.textStyle(
            color: AppColors.lightBackgroundColor,
            fontSize: 14.0,
            weight: FontWeight.normal,
          ),
        ),
      ),
    ),
  );
}

successToast(msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.white,
      fontSize: 14.0);
}

successToastDynamic(msg,Color color) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color??AppColors.primaryColor,
      textColor: Colors.white,
      fontSize: 14.0);
}

shimmerDemo() {
  return SizedBox(
    width: 100.w,
    height: 100.h,
    child: Shimmer.fromColors(
      baseColor: ThemeService().loadThemeFromBox()
          ? AppColors.color4A
          : Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 10.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 10.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 40.0,
                              height: 8,
                              color: Colors.white,
                            ),
                            const Spacer(),
                            Container(
                              width: 70.0,
                              height: 8,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const IntrinsicHeight(
                child: Divider(color: Colors.white),
              ).marginOnly(top: 10),
            ],
          ),
        ),
        itemCount: 10,
      ),
    ),
  );
}

loader(Color color) {
  return Stack(
    children: [
      InkWell(
        onTap: () {},
        child: const SizedBox(
          height: double.infinity,
          width: double.infinity,
        ),
      ),
      Center(
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Lottie.asset(Assets.videoProgressbarBarLoader,
            height: 150, width: 150),
      )
    ],
  );
}

// defaultToast(String msg, String title, color) {
//   Get.snackbar(
//     title,
//     msg,
//     snackPosition: SnackPosition.BOTTOM,
//     colorText: AppColors.lightBackgroundColor,
//     messageText: Text(
//       msg,
//       style: const TextStyle(color: Colors.white),
//     ),
//     backgroundColor: color,
//     duration: const Duration(seconds: 2),
//     margin: const EdgeInsets.all(20),
//     isDismissible: false,
//     snackStyle: SnackStyle.FLOATING,
//   );
// }

/// Images view
networkImageSalons({required image}) {
  return Image.network(
    image,
    fit: BoxFit.cover,
    width: 50.w,
    height: 16.h,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      }
      return Shimmer.fromColors(
        baseColor: const Color.fromRGBO(191, 191, 191, 0.5254901960784314),
        highlightColor: Colors.white,
        child: Container(
          width: 50.w,
          height: 16.h,
          color: Colors.grey,
        ),
      );
    },
    errorBuilder:
        (BuildContext context, Object exception, StackTrace? stackTrace) {
      return Container(
        width: 50.w,
        height: 17.h,
        color: AppColors.lightGrey,
        child: const Icon(
          Icons.image_not_supported,
          color: Colors.white,
          size: 30,
        ), // You can use any widget as a placeholder
      );
    },
  );
}

noDataFound() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        Assets.noDataFound,
        height: 100,
        width: 100,
      ),
      const Text(
        "No data found",
        style: TextStyle(fontSize: 20),
      ).marginOnly(top: 10),
    ],
  ).marginOnly(bottom: 80);
}

loaderTransparent() {
  return Container(
    color: AppColors.transparentBlackNew,
    child: const SpinKitFadingCircle(
      color: Colors.white,
      size: 70.0,
    ).marginOnly(top: 70),
  );
}

textThemeColor() {
  return ThemeService().loadThemeFromBox()
      ? AppColors.lightBackgroundColor
      : AppColors.black;
}
