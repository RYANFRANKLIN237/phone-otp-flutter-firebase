import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:phoneotp/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OTPController());
    var otp;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OtpTextField(
              mainAxisAlignment: MainAxisAlignment.center,
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code) {
                otp = code;
                controller.verifyOTP(otp);
              }),
            const SizedBox(height: 30,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                controller.verifyOTP(otp);
              }, child: const Text('next')),
            )
          ],
        ),
      ),
    );
  }
}
