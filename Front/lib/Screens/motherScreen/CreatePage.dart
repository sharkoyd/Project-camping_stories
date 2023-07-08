import 'dart:convert';

import 'package:CampStories/Screens/motherScreen/readingPage.dart';
import 'package:CampStories/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../Shared Component/Button.dart';
import '../../constant.dart';
import '../ListenersPage/ControllerListenersProfiles.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

String? selectedOption = "1 min"; // Store the selected option
String? selectedOptionAge = "5"; // Store the selected option

List<String> options = [
  '1 min',
  '3 min',
  '5 min',
];

List<String> optionsAge = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
];
bool isLoading = false;
bool isErrorInv = false;

class _CreatePageState extends State<CreatePage> {
  var controllerlistenersprofiles = Get.find<ControllerListenersProfiles>();
  String inv = "";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
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
                    SizedBox(height: height * 0.09),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Generate Custom',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                          text: ' Story',
                          style: GoogleFonts.inter(
                            color: const Color(0xffFD6F40),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )),
                    ])),
                    const SizedBox(height: 50),
                    Text(
                      'Age range:',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      style: const TextStyle(
                        color: Color(0xffF6F6F6),
                        fontSize: 17,
                        fontWeight: FontWeight.w200,
                      ),
                      value: selectedOptionAge, // Current selected option
                      hint: const Text(
                        'Age',
                        style: TextStyle(
                          color: Color(0xffF6F6F6),
                          fontSize: 17,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      // Hint text displayed when no option is selected
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Color(0xffF6F6F6)),

                      onChanged: (newValue) {
                        setState(() {
                          selectedOptionAge =
                              newValue; // Update the selected option
                        });
                      },
                      dropdownColor: const Color(0xff0F0E30),
                      items: optionsAge
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.openSans(
                              color: const Color(0xffF6F6F6),
                              fontSize: 15,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    // SizedBox(
                    //   height: height * 0.08,
                    //   width: width * 1,
                    //   child: TextField(
                    //     style: GoogleFonts.openSans(
                    //       color: const Color(0xffF6F6F6),
                    //       fontSize: 15,
                    //     ),
                    //     textAlign: TextAlign.start,
                    //     decoration: KinputDecoration.copyWith(
                    //       contentPadding: EdgeInsets.zero,
                    //       hintText: '10 years old default',
                    //       hintStyle: GoogleFonts.openSans(
                    //         color: const Color(0xff707576),
                    //         fontSize: 13,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 50),
                    Text(
                      'Involving:',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.08,
                      width: width * 1,
                      child: TextField(
                        onChanged: (String ch) {
                          inv = ch;
                          setState(() {
                            isErrorInv = false;
                          });
                        },
                        style: const TextStyle(
                          color: Color(0xffF6F6F6),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.start,
                        decoration: KinputDecoration.copyWith(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Involving"),
                      ),
                    ),
                    isErrorInv
                        ? Text(
                            "The involving text should be at least 3 words!",
                            style: GoogleFonts.openSans(
                                color: Colors.redAccent, fontSize: 11),
                          )
                        : SizedBox.shrink(),
                    const SizedBox(height: 50),
                    Text(
                      'Duration:',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      style: const TextStyle(
                        color: Color(0xffF6F6F6),
                        fontSize: 17,
                        fontWeight: FontWeight.w200,
                      ),
                      value: selectedOption, // Current selected option
                      hint: const Text(
                        'Title',
                        style: TextStyle(
                          color: Color(0xffF6F6F6),
                          fontSize: 17,
                          fontWeight: FontWeight.w200,
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
                      items:
                          options.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.openSans(
                              color: const Color(0xffF6F6F6),
                              fontSize: 15,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 60),
                    Center(
                        child: SizedBox(
                      width: double.infinity,
                      height: height * 0.07,
                      child: ElevatedButton(
                        onPressed: isLoading == false
                            ? () async {
                                print(inv.split(" ").length);
                                if (inv.split(" ").length < 3) {
                                  setState(() {
                                    isErrorInv = true;
                                  });
                                  print("3asba");
                                  snackbar(
                                      context,
                                      1,
                                      "The involving text should be at least 3 words!",
                                      Colors.redAccent);
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var res = await controllerlistenersprofiles
                                      .createStory(
                                          controllerlistenersprofiles.id,
                                          selectedOption?.replaceAll(
                                              " min", ""),
                                          inv,
                                          selectedOptionAge);
                                  if (res.statusCode == 200) {
                                    setState(() {
                                      isErrorInv = false;
                                      isLoading = false;
                                    });
                                    final responsebody = jsonDecode(res.body);
                                    print(responsebody);
                                    Map<String, dynamic> arguments = {
                                      'content': responsebody["story"],
                                      'title': responsebody["title"],
                                      'audioPlayer': responsebody["audio_file"],
                                    };
                                    //Get.toNamed('/ReadingPage');
                                    Get.to(const ReadingPage(),
                                        arguments: arguments);
                                  } else {
                                    setState(() {
                                      isErrorInv = false;
                                      isLoading = false;
                                    });
                                  }
                                }
                              }
                            : null,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xff382E56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: BorderSide(
                            color: Colors.transparent,
                            width: 1, // Set the border color
                          ),
                        ),
                        child: Text(
                          isLoading == false ? "Create" : "Generating story...",
                          style: GoogleFonts.openSans(
                              color: const Color(0xffF3F3F3),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
