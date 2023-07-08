import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../constant.dart';
import '../../snackBar.dart';
import 'ControllerListenersProfiles.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({Key? key}) : super(key: key);

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

String? selectedOption = 'historical'; // Store the selected option
List<String> options = [
  'action',
  'adventure',
  'comedy',
  'fantasy',
  'mystery',
  'science fiction',
  'fairy tale',
  'animal',
  'educational',
  'historical'
];

class _AddProfilePageState extends State<AddProfilePage> {
  var controllerlistenersprofiles = Get.find<ControllerListenersProfiles>();
  bool isLoading = false;
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
                          height: height * 0.08,
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Text(
                            "Add Profile",
                            style: GoogleFonts.openSans(
                              color: const Color(0xffF6F6F6),
                              fontSize: 19,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 1,
                          child: TextField(
                            onChanged: (String ch) {
                              controllerlistenersprofiles.name = ch;
                            },
                            style: const TextStyle(
                              color: Color(0xffF6F6F6),
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.start,
                            decoration: KinputDecoration.copyWith(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'First Name',
                              hintStyle: const TextStyle(
                                color: Color(0xffF6F6F6),
                                fontSize: 17,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 1,
                          child: TextField(
                            onChanged: (String ch) {
                              controllerlistenersprofiles.age = ch;
                            },
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              color: Color(0xffF6F6F6),
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.start,
                            decoration: KinputDecoration.copyWith(
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Age',
                              hintStyle: const TextStyle(
                                color: Color(0xffF6F6F6),
                                fontSize: 17,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 1,
                          child: DropdownButton<String>(
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
                                selectedOption = newValue;
                                controllerlistenersprofiles.interests =
                                    newValue!;
                                // Update the selected option
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
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    // Drawer from the bottom
                                    return Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xffCED8E4),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      height: height * 0.4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controllerlistenersprofiles
                                                      .changePic("img1");
                                                  Get.back();
                                                },
                                                child: SizedBox(
                                                  height: height * 0.15,
                                                  child: const Image(
                                                    image: AssetImage(
                                                        'images/img1.png'),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controllerlistenersprofiles
                                                      .changePic("img3");
                                                  Get.back();
                                                },
                                                child: SizedBox(
                                                  height: height * 0.15,
                                                  child: const Image(
                                                    image: AssetImage(
                                                        'images/img3.png'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 30),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controllerlistenersprofiles
                                                      .changePic("img4");
                                                  Get.back();
                                                },
                                                child: SizedBox(
                                                  height: height * 0.15,
                                                  child: const Image(
                                                    image: AssetImage(
                                                        'images/img4.png'),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controllerlistenersprofiles
                                                      .changePic("img2");
                                                  Get.back();
                                                },
                                                child: SizedBox(
                                                  height: height * 0.15,
                                                  child: const Image(
                                                    image: AssetImage(
                                                        'images/img2.png'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: SizedBox(
                                height: height * 0.12,
                                child: Obx(
                                  () => Image(
                                    image: AssetImage(
                                        'images/${controllerlistenersprofiles.profilepic.value}.png'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.28,
                              height: height * 0.05,
                              child: ElevatedButton(
                                onPressed: isLoading == false
                                    ? () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (controllerlistenersprofiles
                                                .name.isEmpty ||
                                            controllerlistenersprofiles
                                                .age.isEmpty) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          snackbar(
                                              context,
                                              1,
                                              "You have to fill all the fields",
                                              Colors.redAccent);
                                        } else {
                                          var res =
                                              await controllerlistenersprofiles
                                                  .createProfile();
                                          var resbody = jsonDecode(res.body);
                                          if (res.statusCode == 200) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            snackbar(
                                                context,
                                                1,
                                                resbody["message"],
                                                Colors.green);
                                            Get.toNamed("/ListenersPage");
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            snackbar(
                                                context,
                                                1,
                                                resbody["message"],
                                                Colors.redAccent);
                                          }
                                        }
                                      }
                                    : null,
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xff382E56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  side: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1, // Set the border color
                                  ),
                                ),
                                child: Text(
                                  isLoading == false ? 'Save' : 'Saving...',
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xffF3F3F3),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        )
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
