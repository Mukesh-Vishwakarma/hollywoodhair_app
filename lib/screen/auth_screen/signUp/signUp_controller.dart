import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {

  final formLoginKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  var name ="".obs;
  var email ="".obs;
  var password ="".obs;

}