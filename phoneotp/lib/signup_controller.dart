import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:phoneotp/authentication_repository.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();
  final controller = Get.put(AuthenticationRepository());

  //text field controllers to get data from text fields
final phoneNo = TextEditingController();

//get phone nom from user and pass to auth repository for authentication

void phoneAuthentication(String phoneNo) {
AuthenticationRepository.instance.phoneAuthentication(phoneNo);
}
}