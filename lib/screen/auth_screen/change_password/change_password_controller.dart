import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {

  final formLoginKey = GlobalKey<FormState>();

  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var newPassword ="".obs;
  var confirmPassword ="".obs;

}