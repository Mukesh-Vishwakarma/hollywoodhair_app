


import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app_colors.dart';
import 'assets.dart';

textField(controller,validationMsg,text,hintText,type){
 return TextFormField(
    controller: controller,
    validator: (value) {
      if (value.toString().isEmpty) {
        return validationMsg;
      }
      return null;
    },
    onChanged: (value) {
      text = value;
    },
    decoration: InputDecoration(
      isDense: false,
      contentPadding:
      const EdgeInsets.all(15),
      hintText:hintText,
      hintStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400),
      suffixIcon: type=="password"?Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(Assets.seenPassword,height:5,),
      ):SizedBox(),

      // labelText: hintText,
      // labelStyle: const TextStyle(
      //     color: AppColors.color3D,
      //     fontSize: 14,
      //     fontWeight: FontWeight.w400),
      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(8),
        borderSide: const BorderSide(
            color: AppColors.colorCD,
            width: 0.99),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder:
      const OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(8)),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(8),
        borderSide: const BorderSide(
            color: AppColors.colorCD,
            width: 0.99),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 0,
        ),
      ),
    ),
  );
}

contactNumber(controller,validationMsg,text,hintText,code,context){
  return ////////Contact Number//////////

    Row(
      children: [
        Expanded(
          child:  Container(
            margin:
            const EdgeInsets.only(top: 24),
            // height: 46,
            child: TextFormField(
              controller:controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                    12),
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter a Phone Number";
                } else if (!RegExp(
                    r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                    .hasMatch(value)) {
                  return "Please Enter a Valid Phone Number";
                }
              },
              onChanged: (value) {
                text = value;
              },
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                  const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      showCountryPicker(
                        context: context,
                        //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                        exclude: <String>['KN', 'MF'],
                        favorite: <String>['SE'],
                        //Optional. Shows phone code before the country name.
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          print('Select country: ${country.phoneCode.toString()}');
                          code= country.phoneCode.toString();


                          print('Select code: ${code}');

                        },

                        // Optional. Sets the theme for the country list picker.
                        countryListTheme: CountryListThemeData(
                          // Optional. Sets the border radius for the bottomsheet.
                          borderRadius: BorderRadius.only(
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
                          searchTextStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize:
                      MainAxisSize.min,
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
                        Image.asset(Assets.dropDown,height: 10,width: 10,),


                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          height: 18,
                          width: 2,
                          color:AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                contentPadding:
                const EdgeInsets.all(15),
                // hintText: "Enter Your Contact Number",
                // hintStyle: const TextStyle(
                //     fontSize: 13, fontWeight: FontWeight.w400),
                labelText:hintText,
                labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppColors.grayEB,
                      width: 0.99),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppColors.grayEB,
                      width: 0.99),
                ),
                errorBorder:
                const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.red,
                      width: 0.0),
                ),
                focusedErrorBorder:
                const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8)),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(8),
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





buttom(text){
  return Container(
    width: Get.size.width,

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7),
        color: AppColors.color7C,
    ),
    child:Center(child: Padding(
      padding: EdgeInsets.only(top: 15,bottom: 15),
      child: Text(text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: AppColors.colorFF,
        ),

      ),
    ),),);
}