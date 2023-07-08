import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';
import '../motherScreen/HomePage.dart';
import 'ControllerListenersProfiles.dart';
import 'package:http/http.dart' as http;

var xxxxx;

class ListenersPage extends StatefulWidget {
  const ListenersPage({Key? key}) : super(key: key);

  @override
  State<ListenersPage> createState() => _ListenersPageState();
}

class _ListenersPageState extends State<ListenersPage> {
  @override
  var profiles;
  var controllerlistenersprofiles = Get.put(ControllerListenersProfiles());
  void initState() {
    profiles = controllerlistenersprofiles.getProfiles();
    super.initState();
  }

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
                        SizedBox(
                          height: height * 0.14,
                        ),
                        Center(
                          child: Text(
                            "Who’s listing to the story ?",
                            style: GoogleFonts.poppins(
                              color: const Color(0xffFD6F40),
                              fontSize: 18,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        FutureBuilder<dynamic>(
                            future: profiles,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                Object? e = snapshot.error;
                                String errorMessage = '';
                                if (e is SocketException) {
                                  errorMessage =
                                      'Unable to connect to server. Please check your internet connection.';
                                } else if (e is TimeoutException) {
                                  errorMessage =
                                      'Connection timed out. Please try again later.';
                                } else {
                                  errorMessage = 'An error occurred: $e';
                                }
                                return Text(errorMessage);
                              }
                              if (!snapshot.hasData &&
                                  snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (!snapshot.hasData &&
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                return SizedBox.shrink();
                              }
                              if (snapshot.hasData) {
                                return SizedBox(
                                  height: 320,
                                  width: double.infinity,
                                  child: GridView.builder(
                                    itemCount: snapshot.data.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          2, // Number of columns in the grid
                                      mainAxisSpacing:
                                          10.0, // Spacing between rows
                                      crossAxisSpacing:
                                          10.0, // Spacing between columns
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print(snapshot.data[index]['name']);
                                      return InkWell(
                                        onTap: () async {
                                          controllerlistenersprofiles.id =
                                              snapshot.data[index]['profile_id']
                                                  .toString();
                                          controllerlistenersprofiles
                                                  .resProfileInfo =
                                              await controllerlistenersprofiles
                                                  .getProfileInfo(
                                                      snapshot.data[index]
                                                          ['profile_id']);
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? token =
                                              prefs.getString('token');
                                          final res = await http.get(
                                            Uri.parse(
                                                "$URL/?profile_id=${snapshot.data[index]['profile_id']}"),
                                            headers: {
                                              'Authorization': 'Bearer $token',
                                            },
                                          );

                                          if (res.statusCode == 200) {
                                            // await Future.delayed(
                                            //     Duration(seconds: 2));
                                            Get.toNamed("/MotherScreen");
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: height * 0.148,
                                              child: Image(
                                                image: AssetImage(
                                                    'images/${snapshot.data[index]['profileimg']}.png'),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${snapshot.data[index]['name']}",
                                              style: GoogleFonts.openSans(
                                                color: const Color(0xffE4DBF2),
                                                fontSize: 15,
                                                letterSpacing: 0.02,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return CircularProgressIndicator();
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed('/addProfile');
                          },
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.149,
                                  child: const Image(
                                    image: AssetImage('images/add.png'),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Add Profile",
                                  style: GoogleFonts.openSans(
                                    color: const Color(0xffE4DBF2),
                                    fontSize: 15,
                                    letterSpacing: 0.02,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
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

// ButtonNext(width * 0.87, height * 0.07, "Next",
// const Color(0xff382E56), () {
// Get.toNamed('/SignupFinish');
// }, Colors.transparent),
