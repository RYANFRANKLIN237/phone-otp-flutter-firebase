import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoneotp/authentication_repository.dart';
import 'package:phoneotp/firebase_options.dart';
import 'package:phoneotp/signup_screen.dart';


 Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  .then((value) => Get.put(AuthenticationRepository()));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
     home: GetStartedScreen(),

    );
  }
}


