import 'package:CampStories/Screens/SigninSingnupPage/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'Screens/ListenersPage/AddProfilePage.dart';
import 'Screens/ListenersPage/ListenersPage.dart';
import 'Screens/SigninSingnupPage/SigninSignupPage.dart';
import 'Screens/SigninSingnupPage/SignupFinish.dart';
import 'Screens/SigninSingnupPage/SignupStepFour.dart';
import 'Screens/SigninSingnupPage/SignupStepOne.dart';
import 'Screens/SigninSingnupPage/SignupStepThree.dart';
import 'Screens/SigninSingnupPage/SignupStepTwo.dart';
import 'Screens/StartingPage/StartingPage.dart';
import 'Screens/motherScreen/MotherScreen.dart';
import 'Screens/motherScreen/readingPage.dart';

void main() {
  runApp(const Camp());
}

class Camp extends StatelessWidget {
  const Camp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartingPage(),
      getPages: [
        GetPage(name: '/', page: () => const StartingPage()),
        GetPage(name: '/MotherScreen', page: () => const MotherScreen()),
        GetPage(name: '/signInSignUp', page: () => const SigninSignupPage()),
        GetPage(name: '/SignupStepOne', page: () => const SignupStepOne()),
        GetPage(name: '/SignupStepTwo', page: () => const SignupStepTwo()),
        GetPage(name: '/SignupStepThree', page: () => const SignupStepThree()),
        GetPage(name: '/SignupStepFour', page: () => const SignupStepFour()),
        GetPage(name: '/SignupFinish', page: () => const SignupFinish()),
        GetPage(name: '/ListenersPage', page: () => const ListenersPage()),
        GetPage(name: '/addProfile', page: () => const AddProfilePage()),
        GetPage(name: '/ReadingPage', page: () => const ReadingPage()),
        GetPage(name: '/SignIn', page: () => const SignIn()),
      ],
    );
  }
}
