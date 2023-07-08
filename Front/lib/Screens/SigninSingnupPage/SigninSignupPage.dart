import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../Shared Component/Button.dart';

class SigninSignupPage extends StatelessWidget {
  const SigninSignupPage({Key? key}) : super(key: key);

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
                children: [
                  SizedBox(
                    height: height * 0.3,
                  ),
                  Center(
                    child: Button(double.infinity, height * 0.07, 'Login',
                        const Color(0xff382E56), () {
                      Get.toNamed("/SignIn");
                    }, Colors.transparent),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Button(double.infinity, height * 0.07, 'Signup',
                        const Color(0xff1d113c), () {
                      Get.toNamed('/SignupStepOne');
                    }, const Color(0xff493d6b)),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
