import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../Shared Component/ButtonNext.dart';
import '../../controller/SignUpController.dart';
import '../../snackBar.dart';

class SignupStepOne extends StatelessWidget {
  const SignupStepOne({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var signupcontroller = Get.put(SignUpController());
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
                        Text(
                          "Enter your mobile number",
                          style: GoogleFonts.openSans(
                            color: const Color(0xffF6F6F6),
                            fontSize: 19,
                            letterSpacing: 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: height * 0.0635,
                          width: width * 0.7,
                          child: InternationalPhoneNumberInput(
                            inputDecoration: InputDecoration(
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(
                                        0xffDADADA)), // Change the border color here
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(
                                        0xffDADADA)), // Change the focused border color here
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(
                                        0xffDADADA)), // Change the enabled border color here
                              ),
                              hintText: 'Phone number',
                              hintStyle: GoogleFonts.openSans(
                                  color: const Color(0xffDADADA), fontSize: 14),
                            ),
                            textStyle: const TextStyle(
                              color: Color(0xffDADADA),
                              fontSize: 14,
                            ),
                            isEnabled: true,
                            onInputChanged: (PhoneNumber number) {
                              signupcontroller.country_code = number.dialCode!;
                              signupcontroller.number = number.phoneNumber!;
                              signupcontroller.phone_number =
                                  number.phoneNumber!;
                              signupcontroller.phone_number =
                                  signupcontroller.phone_number.replaceAll(
                                      signupcontroller.country_code, "");
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            spaceBetweenSelectorAndTextField: 0,
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: const TextStyle(
                              color: Color(0xffAEA0D7),
                              fontSize: 14,
                            ),
                            formatInput: true,
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
                    child: Text(
                      "By continuing you may recieve an SMS for verification. Message and data rates may apply.",
                      style: GoogleFonts.openSans(
                        color: const Color(0xff979797),
                        fontSize: 13,
                        letterSpacing: 0.02,
                        fontWeight: FontWeight.w100,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ButtonNext(width * 0.87, height * 0.07, "Next",
                      const Color(0xff382E56), () async {
                    if (signupcontroller.phone_number.isEmpty) {
                      snackbar(
                          context,
                          1,
                          "You have to fill the verification code",
                          Colors.redAccent);
                    } else {
                      var res = await signupcontroller.createAccountPhoneNumber(
                          signupcontroller.phone_number,
                          signupcontroller.country_code);
                      if (res.statusCode == 200) {
                        Get.toNamed('/SignupStepTwo');
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
