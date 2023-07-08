import 'dart:convert';

import 'package:get/get.dart';

import '../constant.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  String phone_number = '';
  String country_code = '';
  String password = '';
  String Confpassword = '';
  String first_name = '';
  String last_name = '';
  String verification_code = '';
  String number = '';
  Future<http.Response> createAccountPhoneNumber(
      phoneNumber, countryCode) async {
    var data = {
      "phone_number": phoneNumber,
      "country_code": countryCode,
    };
    var body = jsonEncode(data);
    final res = await http.post(
      Uri.parse("$URL/PhoneNumConfirm"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    print(res.body);
    return res;
  }

  Future<http.Response> verifyCode(verifCode, phonenbr, countrycod) async {
    var data = {
      "verification_code": verifCode,
      "country_code": countrycod,
      "phone_number": phonenbr,
    };
    var body = jsonEncode(data);
    final res = await http.post(
      Uri.parse("$URL/VerifySignUpCode"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    return res;
  }

  Future<http.Response> createAccountfullInfo(
      phonenumber, countrycode, passwordd, firstname, lastname) async {
    var data = {
      "phone_number": phonenumber,
      "country_code": countrycode,
      "password": passwordd,
      "first_name": firstname,
      "last_name": lastname
    };
    var body = jsonEncode(data);
    final res = await http.post(
      Uri.parse("$URL/RegisterWithPhoneNum"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    return res;
  }

  Future<http.Response> login(
      countrycode, phonenumber, passwordd, firstname, lastname) async {
    var data = {
      "phone_number": phonenumber,
      "country_code": countrycode,
      "password": passwordd,
    };
    var body = jsonEncode(data);
    final res = await http.post(
      Uri.parse("$URL/LoginWithPhoneNum/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    return res;
  }
}
