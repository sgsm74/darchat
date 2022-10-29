import 'dart:math';

import 'package:flutter/material.dart';

class Constants {
  static Color supportChatBackground = const Color(0xFF00AB97);
  static Color customerChatBackground = const Color(0xfff4f4f4);
  static Color kBackgroundColor = const Color(0xffFCEDEA);
  static Color kTextColor = const Color(0xff243443);
  static Color kDisableButtonBackgroundColor = const Color(0xffC3C7CB);
  static Color kBorderColor = const Color(0xffE0E0E0);
  static Color kFocusedBorderColor = const Color(0xff828282);
  static Color kArrowBackIcon = const Color(0xffE9E9EA);
  static double kBorderRadius = 8.0;
  static Color kErrorColor = const Color(0xffEB5757);
  static Color kSendMessageBackgoundColor = const Color(0xffFADDD7);
  static Color kHintColor = const Color(0xff413d4b).withOpacity(0.5);
  static Color kReceiverMessageBackgroundColor = const Color(0xffF6BEB1);
  static Color kSenderMessageBackgroundColor = const Color(0xffFBDEAC);
}

class SokcetData {
  static const String domain = 'darchat.darkube.app';
  static const String url = 'https://$domain';
  static const String websocket = "wss://$domain/websocket";
  static String myToken = "token${Random().nextInt(10000)}";
  static String roomId = "room${Random().nextInt(10000)}";
  static String upload(String roomId) => '$url/api/v1/livechat/upload/$roomId';
}
