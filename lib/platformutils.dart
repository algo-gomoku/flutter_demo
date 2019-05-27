import 'package:flutter/material.dart';

TargetPlatform getPlatform(BuildContext context) {
  return Theme.of(context).platform;
//  return TargetPlatform.iOS;
}

bool isIos(BuildContext context) => getPlatform(context) == TargetPlatform.iOS;