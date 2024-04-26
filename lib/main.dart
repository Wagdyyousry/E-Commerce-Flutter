import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/presentation/screens/navigation_menu/navigation_screen.dart';
import 'package:ecommerce/presentation/screens/onbording_screen.dart';
import 'package:ecommerce/presentation/screens/registeration/signin_screen.dart';
import 'package:ecommerce/presentation/screens/registeration/verify_email_screen.dart';
import 'package:ecommerce/utils/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      //themes
      themeMode: ThemeMode.system,
      theme: CustomAppTheme.lightTheme,
      darkTheme: CustomAppTheme.darkTheme,

      //home screen
      home: checkFirstTimeOnbording(),
    );
  }

  Widget checkFirstTimeOnbording() {
    final user = FirebaseAuth.instance.currentUser;
    final storage = GetStorage();

    if (user != null) {
      if (user.emailVerified) {
        return const NavigationScreen();
      } else {
        return const VerifyEmailScreen();
      }
    }

    storage.writeIfNull("IsFirstTimeOnbording", true);
    if (storage.read("IsFirstTimeOnbording")) {
      return const OnbordingScreen();
    } else {
      return const SignInScreen();
    }
  }
}
/*
An e-commerce app allows users to buy any product with specific size and colors and prices, Rate the products and see all reviews and more ☺️.
built using -
🔻flutter with dart.
🔻MVC architecture patterns.
🔻Firebase(Firestore, auth, storage)
🔻Google Auth & Email Auth.
🔻State management ( Getx ).
🔻SqfLite as local database.
**/