import 'package:flutter/material.dart';
import 'package:plant_project/scan%20screen/crops_scan_screen.dart';
import 'package:plant_project/scan%20screen/fruits_scan_screen.dart';
import 'package:plant_project/scan%20screen/legumes_scan_screen.dart';
import 'package:plant_project/scan%20screen/vegetables_scan_screen.dart';
import 'package:plant_project/screens/forget_password_screen.dart';
import 'package:plant_project/screens/forget_password_three.dart';
import 'package:plant_project/screens/forget_password_two.dart';
import 'package:plant_project/screens/login_screen.dart';
import 'package:plant_project/screens/home_screen.dart';
import 'package:plant_project/screens/profile_screen.dart';
import 'package:plant_project/screens/sign_up_screen.dart';
import 'package:plant_project/screens/welcome_page.dart';
import 'package:plant_project/screens/account_screen.dart';
import 'package:plant_project/screens/splash_screen.dart';
import 'package:plant_project/screens/onboarding_screen.dart';

import 'new screens/chatbot_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/splash': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forget': (context) => ForgetPasswordScreen(),
        '/forget2': (context) => ForgetPasswordTwoScreen(),
        '/forget3': (context) => ForgetPasswordThreeScreen(),
        'home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/account': (context) => AccountScreen(),
        '/crops_scan': (context) => CropsScanScreen(),
        '/vegetables_scan': (context) => VegetablesScanScreen(),
        '/fruits_scan': (context) => FruitsScanScreen(),
        '/legumes_scan': (context) => LegumesScanScreen(),
        '/chatbot': (context) => ChatbotScreen(),
      },
    );
  }
}