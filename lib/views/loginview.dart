import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtysproje/constants/decoration_constants.dart';
import 'package:vtysproje/db/database_services.dart';
import 'package:vtysproje/models/usermodel.dart';
import 'package:vtysproje/views/registerview.dart';
import '../constants/radius_constants.dart';
import 'homeview.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  User? user;
  int index = 0;
  List<Widget> pageList = [
    HomeView(),
  ];
  String username = "";
  String password = "";
  var dbServices = new DatabaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          Container(
            color: DecorationConstants.instance.backgroundColor,
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: DecorationConstants.instance.colorBlue,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(200, 50))),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.home,
                                size: 100,
                                color: Colors.white,
                              ),
                              Text("Emlakçı",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Hoşgeldiniz!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Yüzlerce emlağa ulaşmak için giriş yapın",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  RadiusConstants.instance.circularBorder10,
                              boxShadow: [DecorationConstants.instance.boxshadow]),
                          child: TextField(
                            autocorrect: false,
                            onSubmitted: (text) {
                              username = text.toString();
                            },
                            onChanged: (text) {
                              username = text.toString();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Kullanıcı Adı"),
                          ),
                        ),
                        DecorationConstants.instance.sizedBoxh20,
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  RadiusConstants.instance.circularBorder15,
                              boxShadow: [DecorationConstants.instance.boxshadow]),
                          child: TextField(
                            onSubmitted: (text) {
                              password = text.toString();
                            },
                            onChanged: (text) {
                              password = text.toString();
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Şifre",
                            ),
                            obscureText: true,
                          ),
                        ),
                        DecorationConstants.instance.sizedBoxh20,
                        Container(
                          height: 60,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius:
                                  RadiusConstants.instance.circularBorder30,
                              color: DecorationConstants.instance.colorBlue,
                              boxShadow: [DecorationConstants.instance.boxshadow]),
                          child: loginButton(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterView()));
                            },
                            child: Text("Hesabım Yok"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await DatabaseServices().login(username, password).then((value) async {
          if (value != null) {
            userData = value.createMap();
            postData = [];
            await dbServices.getPosts(statusDetail, minPrice, maxPrice, 0);
            isLoggedIn = true;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeView()));
          } else {
            showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: Text("Hata!"),
                content: Text("Kullanıcı Adı ya da Şifre hatalı!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Tamam"))
                ],
              ),
            );
          }
        });
      },
      style: ElevatedButton.styleFrom(
        primary: DecorationConstants.instance.colorBlue,
        shape: RoundedRectangleBorder(
          borderRadius: RadiusConstants.instance.circularBorder30,
        ),
      ),
      child: Center(
        child: Text(
          "Giriş Yap!",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
