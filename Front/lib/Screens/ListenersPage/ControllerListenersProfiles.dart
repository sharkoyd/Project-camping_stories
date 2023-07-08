import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';

class ControllerListenersProfiles extends GetxController {
  var resProfileInfo;
  String full_name = "";
  String phone_number = "";
  String name = "";
  String age = "";
  String id = "";
  RxString profilepic = "editpic".obs;
  String interests = "";
  RxList<dynamic> listStoriesOneMin = [].obs;
  RxList<dynamic> listStoriesthreeMin = [].obs;
  RxList<dynamic> listStoriesFiveMin = [].obs;
  RxList<dynamic> listStoriesRecommended = [].obs;
  void changePic(pic) {
    profilepic.value = pic;
    update();
  }

  getProfiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    final res = await http.get(Uri.parse("$URL/Profiles"), headers: {
      'Authorization': 'Bearer $token',
    });
    final responsebody = jsonDecode(res.body);
    //print(responsebody["profiles"]);
    return responsebody["profiles"];
  }

  Future<http.Response> createProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var data = {
      "name": name,
      "age": int.parse(age),
      "profilepic": profilepic.value,
      "interests": interests,
    };
    var body = jsonEncode(data);
    final res = await http.post(
      Uri.parse("$URL/CreateProfile/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    print(res.body);
    return res;
  }

  Future getProfileInfo(id) async {
    listStoriesRecommended.value = [];
    listStoriesOneMin.value = [];
    listStoriesthreeMin.value = [];
    listStoriesFiveMin.value = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final res = await http.get(
      Uri.parse("$URL/?profile_id=$id"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final responsebody = jsonDecode(res.body);
    phone_number = responsebody['phone_number'];

    full_name = responsebody['full_name'];
    listStoriesRecommended.value = responsebody['recommended'];
    listStoriesOneMin.value = responsebody['one_minute_stories'];
    listStoriesthreeMin.value = responsebody['three_minute_stories'];
    listStoriesFiveMin.value = responsebody['five_minute_stories'];
    return listStoriesRecommended.value;
  }

  Future createStory(id, duration, inv, age) async {
    var data = {
      "duration": duration,
      "involving": inv,
      "age_range": age,
    };
    var body = jsonEncode(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final res = await http.post(
      Uri.parse("$URL/CustomStory/?profile_id=$id"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    return res;
  }
}
