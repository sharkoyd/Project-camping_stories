import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared Component/Button.dart';
import '../../constant.dart';
import '../../snackBar.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late bool _passwordVisible = true;
  String countryNumber = '';
  String phoneNumber = '';
  String number = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
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
            const Positioned(
                child: Image(
              image: AssetImage('images/CampFireStars.png'),
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.045),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.25),
                  SizedBox(
                    height: height * 0.0635,
                    width: width * 0.86,
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
                      onInputChanged: (PhoneNumber numberr) {
                        countryNumber = numberr.dialCode!;
                        number = numberr.phoneNumber!;
                        phoneNumber = numberr.phoneNumber!;
                        phoneNumber = phoneNumber.replaceAll(countryNumber, "");
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

                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      height: height * 0.08,
                      width: width * 0.85,
                      child: TextField(
                        obscureText: _passwordVisible,
                        style: const TextStyle(
                          color: Color(0xffF6F6F6),
                          fontSize: 18,
                        ),
                        onChanged: (String ch) {
                          password = ch!;
                        },
                        textAlign: TextAlign.start,
                        decoration: KinputDecoration.copyWith(
                          suffixIcon: IconButton(
                            icon: _passwordVisible
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Password',
                          hintStyle: GoogleFonts.openSans(
                            color: Color(0xffF6F6F6),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 25),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     InkWell(
                  //       child: SizedBox(
                  //         height: height * 0.095,
                  //         child: const Image(
                  //           image: AssetImage('images/google.png'),
                  //         ),
                  //       ),
                  //     ),
                  //     InkWell(
                  //       child: SizedBox(
                  //         height: height * 0.095,
                  //         child: const Image(
                  //           image: AssetImage('images/facebook.png'),
                  //         ),
                  //       ),
                  //     ),
                  //     InkWell(
                  //       child: SizedBox(
                  //         height: height * 0.095,
                  //         child: const Image(
                  //           image: AssetImage('images/apple.png'),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Button(double.infinity, height * 0.07, 'Login',
                        const Color(0xff382E56), () async {
                      var data = {
                        "phone_number": phoneNumber,
                        "country_code": countryNumber,
                        "password": password,
                      };
                      var body = jsonEncode(data);
                      final res = await http.post(
                        Uri.parse("$URL/LoginWithPhoneNum/"),
                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: body,
                      );
                      final responsebody = jsonDecode(res.body);
                      if (res.statusCode == 200) {
                        final token = responsebody['access'];

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('token', token);
                        Get.toNamed("/ListenersPage");
                      } else {
                        snackbar(context, 1, responsebody["message"],
                            Colors.redAccent);
                      }
                    }, Colors.transparent),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
