import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../Shared Component/ButtonNext.dart';
import '../../constant.dart';
import '../../controller/SignUpController.dart';
import '../../snackBar.dart';

class SignupStepThree extends StatefulWidget {
  const SignupStepThree({Key? key}) : super(key: key);

  @override
  State<SignupStepThree> createState() => _SignupStepThreeState();
}

String? selectedOption = "Father"; // Store the selected option
List<String> options = ['Father', 'Mother'];

class _SignupStepThreeState extends State<SignupStepThree> {
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
                            "Enter your details",
                            style: GoogleFonts.openSans(
                              color: const Color(0xffF6F6F6),
                              fontSize: 19,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: height * 0.08,
                              width: width * 0.35,
                              child: TextField(
                                style: const TextStyle(
                                  color: Color(0xffF6F6F6),
                                  fontSize: 18,
                                ),
                                onChanged: (String ch) {
                                  signupcontroller.first_name = ch!;
                                },
                                textAlign: TextAlign.start,
                                decoration: KinputDecoration.copyWith(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'First',
                                  hintStyle: const TextStyle(
                                    color: Color(0xffF6F6F6),
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.08,
                              width: width * 0.35,
                              child: TextField(
                                style: const TextStyle(
                                  color: Color(0xffF6F6F6),
                                  fontSize: 18,
                                ),
                                onChanged: (String ch) {
                                  signupcontroller.last_name = ch!;
                                },
                                textAlign: TextAlign.start,
                                decoration: KinputDecoration.copyWith(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Last',
                                  hintStyle: const TextStyle(
                                    color: Color(0xffF6F6F6),
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 70),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 0.35,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            style: const TextStyle(
                              color: Color(0xffF6F6F6),
                              fontSize: 18,
                            ),
                            value: selectedOption, // Current selected option
                            hint: const Text(
                              'Title',
                              style: TextStyle(
                                color: Color(0xffF6F6F6),
                                fontSize: 18,
                              ),
                            ),
                            // Hint text displayed when no option is selected
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Color(0xffF6F6F6)),

                            onChanged: (newValue) {
                              setState(() {
                                selectedOption =
                                    newValue; // Update the selected option
                              });
                            },
                            dropdownColor: const Color(0xff0F0E30),
                            items: options
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: Color(0xffF6F6F6),
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: height * 0.29),
                      ],
                    ),
                  ),
                  ButtonNext(width * 0.87, height * 0.07, "Next",
                      const Color(0xff382E56), () {
                    if (signupcontroller.first_name.isEmpty ||
                        signupcontroller.last_name.isEmpty) {
                      snackbar(context, 1, "You have to fill all the fields",
                          Colors.redAccent);
                    } else {
                      Get.toNamed('/SignupStepFour');
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
