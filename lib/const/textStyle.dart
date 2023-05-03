import 'package:flutter/material.dart';
import 'package:muzic/const/colors.dart';


ourTextStyle({
  double? size = 14.0, color = whiteColor, family = 'Barlow'
}){
  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: family,
  );
}