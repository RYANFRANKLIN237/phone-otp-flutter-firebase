import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final _auth = FirebaseAuth.instance;
  var verificationId = ''.obs;
  RecaptchaVerifier? recaptchaVerifier;

  Future<void> phoneAuthentication(phoneNo) async {

    if(kIsWeb){
      RecaptchaVerifier recaptchaVerifier = RecaptchaVerifier(
        container: 'recaptcha-container', // Replace with your container ID (optional)
        size: RecaptchaVerifierSize.compact,
        theme: RecaptchaVerifierTheme.light,
        auth: FirebaseAuthPlatform.instance,
      );
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid phone number') {
            Get.snackbar('Error', 'the provided number is invalid');
          } else {
            Get.snackbar('Error', 'something went wrong');
          }
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },

        timeout: const Duration(seconds: 60),
        forceResendingToken: null,

      );

      // Invoke the recaptcha verifier
      await recaptchaVerifier.verify();
    } else {
      // Mobile specific code
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is invalid');
          } else {
            Get.snackbar('Error', 'Something went wrong');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
        timeout: const Duration(seconds: 60),
        forceResendingToken: null,
      );
    }

  }

  Future<bool> verifyOTP(String otp) async {
    try {
      // Sign in with the provided OTP
      var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId.value,
          smsCode: otp,
        ),
      );

      // Check if the user is not null (authentication successful)
      if (credentials.user != null) {
        // Return true indicating successful authentication
        return true;
      } else {
        // Return false indicating authentication failure
        return false;
      }
    } catch (e) {
      // Handle any errors during authentication
      print('Error verifying OTP: $e');
      // Return false indicating authentication failure
      return false;
    }
  }
}
