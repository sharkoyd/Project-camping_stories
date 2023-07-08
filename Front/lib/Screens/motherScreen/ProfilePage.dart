import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import '../ListenersPage/ControllerListenersProfiles.dart';
import 'ControllerBottomNavigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

TextEditingController name = TextEditingController();

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controllerlistenersprofiles = Get.find<ControllerListenersProfiles>();
    fullname.text = controllerlistenersprofiles.full_name;
    phonenumber.text = controllerlistenersprofiles.phone_number;

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
                        SizedBox(
                          height: height * 0.08,
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Text(
                            "My Account",
                            style: GoogleFonts.openSans(
                              color: const Color(0xffF6F6F6),
                              fontSize: 19,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'full Name:',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 1,
                          child: TextField(
                            enabled: false,
                            style: GoogleFonts.openSans(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            controller: fullname,
                            textAlign: TextAlign.start,
                            decoration: KinputDecoration.copyWith(
                              contentPadding: EdgeInsets.zero,
                              hintStyle: GoogleFonts.openSans(
                                color: const Color(0xffF6F6F6),
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Phone Number:',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 1,
                          child: TextField(
                            enabled: false,
                            controller: phonenumber,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                            decoration: KinputDecoration.copyWith(
                              contentPadding: EdgeInsets.zero,
                              hintText: '+1 250 555 0199',
                              hintStyle: const TextStyle(
                                color: Color(0xffF6F6F6),
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 1,
                          child: TextField(
                            enabled: false,
                            style: const TextStyle(
                              color: Color(0xffF6F6F6),
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.start,
                            decoration: KinputDecoration.copyWith(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Plan',
                              suffixIcon: const Text("Comming soon",
                                  style: TextStyle(
                                      color: Color(0xffF6F6F6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200)),
                              hintStyle: const TextStyle(
                                color: Color(0xffF6F6F6),
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 1,
                          child: TextField(
                            enabled: false,
                            style: const TextStyle(
                              color: Color(0xffF6F6F6),
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.start,
                            decoration: KinputDecoration.copyWith(
                              suffixIcon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xffF6F6F6),
                              ),
                              contentPadding: EdgeInsets.zero,
                              hintText: "Terms & Privacy Policy",
                              hintStyle: const TextStyle(
                                color: Color(0xffF6F6F6),
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 45),
                        Center(
                          child: SizedBox(
                            width: width * 0.4,
                            height: height * 0.061,
                            child: ElevatedButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.remove('token');
                                Get.offAllNamed('/signIn');
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xffFD6F40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1, // Set the border color
                                ),
                              ),
                              child: Text(
                                'Log out',
                                style: GoogleFonts.poppins(
                                    color: const Color(0xffF3F3F3),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
