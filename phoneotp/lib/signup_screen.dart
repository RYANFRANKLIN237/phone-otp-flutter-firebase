import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoneotp/otp_screen.dart';
import 'package:phoneotp/signup_controller.dart';


class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.phoneNo,
                  decoration: const InputDecoration(label: Text('Phoneno')),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()) {
                      SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                      Get.to(() => const OTPScreen());
                    }
                  }, child: const Text('Continue')),
                )
              ],
            )),
      ),
    );
  }
}
