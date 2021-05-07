import 'package:flutter/material.dart';
import 'package:vtysproje/db/database_services.dart';
import 'package:vtysproje/views/homeview.dart';

void main() async {
  await DatabaseServices().getPosts(statusDetail, minPrice, maxPrice, 0);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emlakçı Otomasyon',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
