import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
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
                image: AssetImage('images/Camp.png'),
              )),
              Positioned(
                left: width * 0.08,
                top: height * 0.59,
                child: SizedBox(
                  width: width * 0.77,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Campfire Stories!',
                        style: GoogleFonts.openSans(
                          color: const Color(0xffAEA0D7),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        "“Your imagination is our inspiration, tell us what your child want and we will create stories they’ll love”",
                        style: GoogleFonts.openSans(
                          color: const Color(0xffD7D6D9),
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.08,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * 0.81,
                  ),
                  Center(
                    child: SizedBox(
                      width: width * 0.8,
                      height: height * 0.07,
                      child: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? token = prefs.getString('token');
                          if (token != null && token.isNotEmpty) {
                            Get.toNamed('/ListenersPage');
                          } else {
                            Get.toNamed('/signInSignUp');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff382E56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Get Started!',
                          style: GoogleFonts.openSans(
                              color: const Color(0xffF3F3F3),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Image(
                    image: AssetImage('images/ellipse.png'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
