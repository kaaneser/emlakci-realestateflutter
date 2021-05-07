import 'package:flutter/material.dart';

class RadiusConstants
{
  static RadiusConstants instance = RadiusConstants._init();
  RadiusConstants._init();

  final circularBorder10 = BorderRadius.circular(10);
  final circularBorder15 = BorderRadius.circular(15);
  final circularBorder30 = BorderRadius.circular(30);
  final circular30 = Radius.circular(30);
}