import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../constant.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({Key? key}) : super(key: key);

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  var player;
  bool isPlaying = false;
  int isPlayingfirstTime = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.pause();
    isPlayingfirstTime = 0;
    isPlaying = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    player = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> receivedArguments = Get.arguments;
    String content = receivedArguments['content'];
    String audioPlayer = receivedArguments['audioPlayer'];
    String title = receivedArguments['title'];
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
                        SizedBox(height: height * 0.09),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: '"',
                                  style: GoogleFonts.openSans(
                                    color: const Color(0xffFD6F40),
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                  )),
                              TextSpan(
                                  text: title,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xffE4DBF2),
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                  )),
                              TextSpan(
                                  text: '"',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xffFD6F40),
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ])),
                        const SizedBox(height: 40),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: content,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  height: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                String url = URL + audioPlayer;
                                if (isPlaying == false &&
                                    isPlayingfirstTime == 0) {
                                  await player.play(UrlSource(url));
                                  isPlayingfirstTime++;
                                }
                                if (isPlaying == false &&
                                    isPlayingfirstTime == 0) {
                                  await player.play(UrlSource(url));
                                  isPlayingfirstTime++;
                                }
                                if (isPlaying == false &&
                                    isPlayingfirstTime != 0) {
                                  await player.resume();
                                }
                                if (isPlaying == true) {
                                  await player.pause();
                                }
                                setState(() {
                                  isPlaying = !isPlaying;
                                });
                              },
                              child: SizedBox(
                                  height: height * 0.05,
                                  child: isPlaying
                                      ? SvgPicture.string(
                                          '''
                                          <svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" viewBox="0 0 45 45" fill="none">
                                        <path d="M28.7397 13.0237C28.039 13.1405 27.5403 13.7649 27.5897 14.4612C27.6167 14.8835 27.7335 15.0991 28.2007 15.6067C29.764 17.2958 30.6983 19.1915 31.0892 21.469C31.2239 22.2372 31.2329 24.052 31.1116 24.8382C30.7567 27.0888 29.8134 29.0474 28.277 30.7229C27.7155 31.3339 27.5987 31.5675 27.5987 32.0481C27.6032 32.4794 27.702 32.7354 27.9761 33.0095C28.4927 33.5261 29.2923 33.5755 29.8358 33.1218C30.0515 32.9421 30.7163 32.2054 31.0487 31.7786C31.8843 30.7095 32.7288 29.1911 33.1645 27.9827C34.3909 24.5552 34.2561 20.8446 32.7782 17.5384C32.1808 16.1907 31.2374 14.7892 30.1907 13.6931C29.7774 13.2528 29.5393 13.0911 29.2608 13.0462C29.162 13.0282 29.0497 13.0102 29.0138 13.0013C28.9778 12.9968 28.852 13.0058 28.7397 13.0237Z" fill="#F6F6F6"/>
                                        <path d="M20.9188 14.3893C20.6808 14.4747 20.7302 14.4387 18.3583 16.2177L16.22 17.8259L14.0683 17.8393C11.6605 17.8528 11.7638 17.8393 11.3864 18.1897C11.2517 18.3155 11.1528 18.4593 11.0899 18.621C11.0001 18.8636 11.0001 18.9489 11.0001 23.2165C11.0001 27.9962 10.9866 27.785 11.2741 28.1309C11.3505 28.2208 11.5077 28.351 11.62 28.4229L11.8312 28.5442L14.0009 28.5577L16.1751 28.5712L18.4032 30.2378C19.6341 31.1542 20.7167 31.9403 20.8155 31.9852C21.0581 32.0975 21.4894 32.0975 21.7499 31.9852C21.961 31.8954 22.2396 31.6393 22.3563 31.4192C22.4282 31.2934 22.4327 30.6196 22.4462 23.2659L22.4552 15.2518L22.3429 15.0137C22.2171 14.7622 22.0509 14.6005 21.7679 14.4522C21.5343 14.3354 21.139 14.304 20.9188 14.3893Z" fill="#F6F6F6"/>
                                        <path d="M25.0606 16.1817C24.3644 16.3793 23.9466 17.0577 24.0769 17.7719C24.1353 18.0998 24.2296 18.2481 24.6698 18.7512C26.1073 20.3864 26.6823 22.5426 26.2286 24.6135C25.9726 25.786 25.4919 26.7069 24.6024 27.7266C24.4362 27.9198 24.2565 28.1534 24.2071 28.2522C23.722 29.2045 24.4542 30.3411 25.5009 30.2602C25.9276 30.2288 26.2062 30.067 26.6374 29.6088C27.9671 28.1848 28.7892 26.4823 29.0856 24.5057C29.1845 23.8454 29.1845 22.5202 29.0856 21.8733C28.8251 20.2022 28.2546 18.8321 27.2798 17.5383C26.7497 16.8331 26.3364 16.4153 26.0265 16.276C25.7255 16.1368 25.3437 16.1008 25.0606 16.1817Z" fill="#F6F6F6"/>
                                        <rect x="1.25" y="1.25" width="42.5" height="42.5" rx="21.25" stroke="#FD6F40" stroke-width="2.5"/>
                                        <path d="M35.5 5.5L9 39.5" stroke="#FD6F40" stroke-width="2.5"/>
                                        </svg>
                                          ''',
                                          width: 200,
                                          height: 200,
                                        )
                                      : SvgPicture.string(
                                          '''
                                          <svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" viewBox="0 0 45 45" fill="none">
                                        <path d="M28.7397 13.0237C28.039 13.1405 27.5403 13.7649 27.5897 14.4612C27.6167 14.8835 27.7335 15.0991 28.2007 15.6067C29.764 17.2958 30.6983 19.1915 31.0892 21.469C31.2239 22.2372 31.2329 24.052 31.1116 24.8382C30.7567 27.0888 29.8134 29.0474 28.277 30.7229C27.7155 31.3339 27.5987 31.5675 27.5987 32.0481C27.6032 32.4794 27.702 32.7354 27.9761 33.0095C28.4927 33.5261 29.2923 33.5755 29.8358 33.1218C30.0515 32.9421 30.7163 32.2054 31.0487 31.7786C31.8843 30.7095 32.7288 29.1911 33.1645 27.9827C34.3909 24.5552 34.2561 20.8446 32.7782 17.5384C32.1808 16.1907 31.2374 14.7892 30.1907 13.6931C29.7774 13.2528 29.5393 13.0911 29.2608 13.0462C29.162 13.0282 29.0497 13.0102 29.0138 13.0013C28.9778 12.9968 28.852 13.0058 28.7397 13.0237Z" fill="#F6F6F6"/>
                                        <path d="M20.9188 14.3893C20.6808 14.4747 20.7302 14.4387 18.3583 16.2177L16.22 17.8259L14.0683 17.8393C11.6605 17.8528 11.7638 17.8393 11.3864 18.1897C11.2517 18.3155 11.1528 18.4593 11.0899 18.621C11.0001 18.8636 11.0001 18.9489 11.0001 23.2165C11.0001 27.9962 10.9866 27.785 11.2741 28.1309C11.3505 28.2208 11.5077 28.351 11.62 28.4229L11.8312 28.5442L14.0009 28.5577L16.1751 28.5712L18.4032 30.2378C19.6341 31.1542 20.7167 31.9403 20.8155 31.9852C21.0581 32.0975 21.4894 32.0975 21.7499 31.9852C21.961 31.8954 22.2396 31.6393 22.3563 31.4192C22.4282 31.2934 22.4327 30.6196 22.4462 23.2659L22.4552 15.2518L22.3429 15.0137C22.2171 14.7622 22.0509 14.6005 21.7679 14.4522C21.5343 14.3354 21.139 14.304 20.9188 14.3893Z" fill="#F6F6F6"/>
                                        <path d="M25.0606 16.1817C24.3644 16.3793 23.9466 17.0577 24.0769 17.7719C24.1353 18.0998 24.2296 18.2481 24.6698 18.7512C26.1073 20.3864 26.6823 22.5426 26.2286 24.6135C25.9726 25.786 25.4919 26.7069 24.6024 27.7266C24.4362 27.9198 24.2565 28.1534 24.2071 28.2522C23.722 29.2045 24.4542 30.3411 25.5009 30.2602C25.9276 30.2288 26.2062 30.067 26.6374 29.6088C27.9671 28.1848 28.7892 26.4823 29.0856 24.5057C29.1845 23.8454 29.1845 22.5202 29.0856 21.8733C28.8251 20.2022 28.2546 18.8321 27.2798 17.5383C26.7497 16.8331 26.3364 16.4153 26.0265 16.276C25.7255 16.1368 25.3437 16.1008 25.0606 16.1817Z" fill="#F6F6F6"/>
                                       
                                        </svg>
                                          ''',
                                          width: 200,
                                          height: 200,
                                        )),
                            ),
                            const SizedBox(height: 20),
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
