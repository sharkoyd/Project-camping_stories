import 'dart:convert';

import 'package:CampStories/controller/SignUpController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Shared Component/ButtonNext.dart';
import '../../constant.dart';
import '../../snackBar.dart';

class SignupStepTwo extends StatelessWidget {
  const SignupStepTwo({Key? key}) : super(key: key);

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
            Positioned(
                top: 20,
                left: 25,
                child: InkWell(
                  onTap: () {
                    signupcontroller.verification_code = "";
                    Get.back();
                  },
                  child: const Image(
                    image: AssetImage('images/Vector.png'),
                  ),
                )),
            Positioned(
              top: height * 0.16,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.8,
                          child: Text(
                            "Enter the 4-digit code sent to you at",
                            style: GoogleFonts.openSans(
                              color: const Color(0xffF6F6F6),
                              fontSize: 19,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        Text(
                          '${signupcontroller.number}',
                          style: GoogleFonts.openSans(
                              color: Colors.grey,
                              fontSize: 13,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20),
                            SizedBox(
                              height: height * 0.08,
                              width: width * 0.1,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (String ch) {
                                  signupcontroller.verification_code =
                                      signupcontroller.verification_code + ch;
                                },
                                style: TextStyle(
                                  color: Color(0xffAEA0D7),
                                  fontSize: 20,
                                ),
                                maxLength: 1,
                                textAlign: TextAlign.center,
                                decoration: KinputDecoration,
                              ),
                            ),
                            const SizedBox(width: 35),
                            SizedBox(
                              height: height * 0.08,
                              width: width * 0.1,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (String ch) {
                                  signupcontroller.verification_code =
                                      signupcontroller.verification_code + ch;
                                },
                                style: TextStyle(
                                  color: Color(0xffAEA0D7),
                                  fontSize: 20,
                                ),
                                maxLength: 1,
                                textAlign: TextAlign.center,
                                decoration: KinputDecoration,
                              ),
                            ),
                            const SizedBox(width: 35),
                            SizedBox(
                              height: height * 0.08,
                              width: width * 0.1,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (String ch) {
                                  signupcontroller.verification_code =
                                      signupcontroller.verification_code + ch;
                                },
                                style: TextStyle(
                                  color: Color(0xffAEA0D7),
                                  fontSize: 20,
                                ),
                                maxLength: 1,
                                textAlign: TextAlign.center,
                                decoration: KinputDecoration,
                              ),
                            ),
                            const SizedBox(width: 35),
                            SizedBox(
                              height: height * 0.08,
                              width: width * 0.1,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (String ch) {
                                  signupcontroller.verification_code =
                                      signupcontroller.verification_code + ch;
                                },
                                style: TextStyle(
                                  color: Color(0xffAEA0D7),
                                  fontSize: 20,
                                ),
                                maxLength: 1,
                                textAlign: TextAlign.center,
                                decoration: KinputDecoration,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Resent the code",
                            style: GoogleFonts.openSans(
                              color: const Color(0xFFAEA0D7),
                              fontSize: 14,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: height * 0.77,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 1,
                    // child: Text(
                    //   "By continuing you may recieve an SMS for verification. Message and data rates may apply.",
                    //   style: GoogleFonts.openSans(
                    //     color: Color(0xff979797),
                    //     fontSize: 13,
                    //     letterSpacing: 0.02,
                    //     fontWeight: FontWeight.w100,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                  ),
                  const SizedBox(height: 50),
                  ButtonNext(width * 0.87, height * 0.07, "Next",
                      const Color(0xff382E56), () async {
                    if (signupcontroller.verification_code.length != 4) {
                      snackbar(
                          context,
                          1,
                          "You have to fill the verification code",
                          Colors.redAccent);
                    } else {
                      Get.toNamed('/SignupStepThree');
                      var res = await signupcontroller.verifyCode(
                          signupcontroller.verification_code,
                          signupcontroller.phone_number,
                          signupcontroller.country_code);
                      if (res.statusCode == 200) {
                        Get.toNamed('/SignupStepThree');
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
