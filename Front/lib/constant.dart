import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const KinputDecoration = InputDecoration(
  contentPadding: EdgeInsets.only(bottom: 10),
  border: UnderlineInputBorder(
    borderSide:
        BorderSide(color: Color(0xffDADADA)), // Change the border color here
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
        color: Color(0xffDADADA)), // Change the focused border color here
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
        color: Color(0xffDADADA)), // Change the enabled border color here
  ),
  disabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xffDADADA)),
  ),
);

const URL = "http://192.168.1.14:8000";
