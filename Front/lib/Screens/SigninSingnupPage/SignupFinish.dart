import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Shared Component/ButtonNext.dart';

class SignupFinish extends StatelessWidget {
  const SignupFinish({Key? key}) : super(key: key);

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
            const Image(
              image: AssetImage('images/Group219.png'),
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
                          height: height * 0.44,
                        ),
                        Text(
                          "“Your imagination is our inspiration–if you provide us details like age and interests of the people you want to tell stories to, then we can help you create stories they’ll love !”",
                          style: GoogleFonts.openSans(
                            color: const Color(0xffD7D6D9),
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height * 0.124),
                      ],
                    ),
                  ),
                  ButtonNext(width * 0.87, height * 0.07, "Start",
                      const Color(0xff382E56), () {
                    Get.toNamed('/SignIn');
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
