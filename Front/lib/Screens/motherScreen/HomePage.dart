import 'dart:async';
import 'dart:io';

import 'package:CampStories/Screens/motherScreen/readingPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant.dart';
import '../ListenersPage/ControllerListenersProfiles.dart';
import 'ControllerBottomNavigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  var profileStories;
  var controllerlistenersprofiles = Get.find<ControllerListenersProfiles>();

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controllerNav = Get.find<ControllerBottomNavigation>();
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
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Suggested for',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                          TextSpan(
                              text: ' you',
                              style: GoogleFonts.inter(
                                color: const Color(0xffFD6F40),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                          TextSpan(
                              text: ' :',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ))
                        ])),
                        InkWell(
                          onTap: () {
                            Get.toNamed('/ListenersPage');
                          },
                          child: SizedBox(
                            height: height * 0.06,
                            child: const Image(
                              image: AssetImage('images/img4.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.16,
                      child: Obx(() {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controllerlistenersprofiles
                              .listStoriesRecommended.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: InkWell(
                                onTap: () {
                                  Map<String, dynamic> arguments = {
                                    'content': controllerlistenersprofiles
                                        .listStoriesFiveMin[index]["content"],
                                    'title': controllerlistenersprofiles
                                        .listStoriesFiveMin[index]["title"],
                                    'audioPlayer': controllerlistenersprofiles
                                            .listStoriesFiveMin[index]
                                        ["audio_file"],
                                  };
                                  //Get.toNamed('/ReadingPage');
                                  Get.to(const ReadingPage(),
                                      arguments: arguments);
                                },
                                child: SizedBox(
                                  height: height * 0.2,
                                  child: Stack(
                                    children: [
                                      Image(
                                        image: NetworkImage(
                                            '$URL${controllerlistenersprofiles.listStoriesOneMin[index]["picture"]["picture"]}'),
                                      ),
                                      Positioned(
                                        top: height *
                                            0.105, // Adjust the position as per your requirement
                                        left:
                                            0, // Adjust the position as per your requirement
                                        child: SizedBox(
                                          width: width * 0.33,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0),
                                            child: Center(
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: '"',
                                                    style: GoogleFonts.inter(
                                                      color: Color(0xffFD6F40),
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                                TextSpan(
                                                  text: controllerlistenersprofiles
                                                          .listStoriesFiveMin[
                                                      index]["title"],
                                                  style: GoogleFonts.inter(
                                                    color: Color(0xffE4DBF2),
                                                    fontSize: 7,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: '"',
                                                    style: GoogleFonts.inter(
                                                      color: Color(0xffFD6F40),
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ))
                                              ])),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "1 min Story :",
                      style: GoogleFonts.inter(
                        color: const Color(0xffFD6F40),
                        fontSize: 12,
                        letterSpacing: 0.02,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.135,
                      child: Obx(() {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controllerlistenersprofiles
                              .listStoriesOneMin.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: InkWell(
                                onTap: () {
                                  Map<String, dynamic> arguments = {
                                    'content': controllerlistenersprofiles
                                        .listStoriesFiveMin[index]["content"],
                                    'title': controllerlistenersprofiles
                                        .listStoriesFiveMin[index]["title"],
                                    'audioPlayer': controllerlistenersprofiles
                                            .listStoriesFiveMin[index]
                                        ["audio_file"],
                                  };
                                  //Get.toNamed('/ReadingPage');
                                  Get.to(const ReadingPage(),
                                      arguments: arguments);
                                },
                                child: SizedBox(
                                  height: height * 0.135,
                                  child: Image(
                                    image: NetworkImage(
                                        '$URL${controllerlistenersprofiles.listStoriesOneMin[index]["picture"]["picture"]}'),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "3 min Story :",
                      style: GoogleFonts.inter(
                        color: const Color(0xffFD6F40),
                        fontSize: 12,
                        letterSpacing: 0.02,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.135,
                      child: Obx(() {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controllerlistenersprofiles
                              .listStoriesthreeMin.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: InkWell(
                                onTap: () {
                                  Map<String, dynamic> arguments = {
                                    'content': controllerlistenersprofiles
                                        .listStoriesFiveMin[index]["content"],
                                    'title': controllerlistenersprofiles
                                        .listStoriesFiveMin[index]["title"],
                                    'audioPlayer': controllerlistenersprofiles
                                            .listStoriesFiveMin[index]
                                        ["audio_file"],
                                  };
                                  //Get.toNamed('/ReadingPage');
                                  Get.to(const ReadingPage(),
                                      arguments: arguments);
                                },
                                child: SizedBox(
                                  height: height * 0.135,
                                  child: Image(
                                    image: NetworkImage(
                                        '$URL${controllerlistenersprofiles.listStoriesOneMin[index]["picture"]["picture"]}'),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "5 min Story :",
                      style: GoogleFonts.inter(
                        color: const Color(0xffFD6F40),
                        fontSize: 12,
                        letterSpacing: 0.02,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.135,
                      child: Obx(() {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controllerlistenersprofiles
                              .listStoriesFiveMin.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: InkWell(
                                onTap: () {
                                  Map<String, dynamic> arguments = {
                                    'content': controllerlistenersprofiles
                                        .listStoriesFiveMin[index]["content"],
                                    'title': controllerlistenersprofiles
                                        .listStoriesFiveMin[index]["title"],
                                    'audioPlayer': controllerlistenersprofiles
                                            .listStoriesFiveMin[index]
                                        ["audio_file"],
                                  };
                                  //Get.toNamed('/ReadingPage');
                                  Get.to(const ReadingPage(),
                                      arguments: arguments);
                                },
                                child: Image(
                                  image: NetworkImage(
                                      '$URL${controllerlistenersprofiles.listStoriesFiveMin[index]["picture"]["picture"]}'),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
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
