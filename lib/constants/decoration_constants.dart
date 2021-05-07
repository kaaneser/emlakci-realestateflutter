import 'package:flutter/material.dart';

class DecorationConstants {
  static DecorationConstants instance = DecorationConstants._init();
  DecorationConstants._init();

  final colorBlue = Color.fromARGB(255, 101, 204, 252);
  final backgroundColor = Colors.white;
  final boxshadow = BoxShadow(
    offset: Offset(10, 10),
    color: Colors.grey,
    blurRadius: 10,
  );
  final sizedBoxw10 = SizedBox(
    width: 10,
  );
  final sizedBoxh10 = SizedBox(
    height: 10,
  );
  final sizedBoxh20 = SizedBox(
    height: 20,
  );
  final searchInputBorder =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.black45));
}
