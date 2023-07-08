import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Shared Component/ButtonNext.dart';
import '../../constant.dart';
import '../../controller/SignUpController.dart';
import '../../snackBar.dart';

class SignupStepFour extends StatelessWidget {
  const SignupStepFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var signupcontroller = Get.find<SignUpController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Color(0xff0F0E30),
              ),
            ),
            const Image(
              image: AssetImage('images/Stars.png'),
              fit: BoxFit.fill,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Image(
                              image: AssetImage('images/Vector.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.11,
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Text(
                            "Create Password",
                            style: GoogleFonts.openSans(
                              color: const Color(0xffF6F6F6),
                              fontSize: 19,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 70),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 1,
                          child: TextField(
                            obscureText: true,
                            style: const TextStyle(
                              color: Color(0xffF6F6F6),
                              fontSize: 18,
                            ),
                            onChanged: (String ch) {
                              signupcontroller.password = ch;
                            },
                            textAlign: TextAlign.start,
                            decoration: KinputDecoration.copyWith(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                color: Color(0xffF6F6F6),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 70),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 1,
                          child: TextField(
                            obscureText: true,
                            style: const TextStyle(
                              color: Color(0xffF6F6F6),
                              fontSize: 18,
                            ),
                            onChanged: (String ch) {
                              signupcontroller.Confpassword = ch;
                            },
                            textAlign: TextAlign.start,
                            decoration: KinputDecoration.copyWith(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Confirm Password',
                              hintStyle: const TextStyle(
                                color: Color(0xffF6F6F6),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.29),
                      ],
                    ),
                  ),
                  ButtonNext(width * 0.87, height * 0.07, "Next",
                      const Color(0xff382E56), () async {
                    if (signupcontroller.password.isEmpty ||
                        signupcontroller.Confpassword.isEmpty ||
                        signupcontroller.password !=
                            signupcontroller.Confpassword) {
                      snackbar(context, 1, "Confirm your password",
                          Colors.redAccent);
                    } else {
                      var res = await signupcontroller.createAccountfullInfo(
                        signupcontroller.phone_number,
                        signupcontroller.country_code,
                        signupcontroller.password,
                        signupcontroller.first_name,
                        signupcontroller.last_name,
                      );
                      if (res.statusCode == 200) {
                        Get.toNamed('/SignupFinish');
                      } else {
                        var response = jsonDecode(res.body);
                        snackbar(
                            context, 1, response["message"], Colors.redAccent);
                      }
                    }
                  }, Colors.transparent),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
