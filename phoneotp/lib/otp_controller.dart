import 'package:get/get.dart';
import 'package:phoneotp/authentication_repository.dart';
import 'package:phoneotp/welcome.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async{
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const WelcomeScreen()) : Get.back();
  }
}