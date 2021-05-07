import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtysproje/constants/decoration_constants.dart';
import 'package:vtysproje/constants/radius_constants.dart';
import 'package:vtysproje/db/database_services.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  int index = 0;
  String username = "";
  String password = "";
  String mail = "";
  String firstName = "";
  String lastName = "";
  String phoneNum = "";
  var dbServices = new DatabaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        shrinkWrap: false,
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
                          "Hadi sizi tanıyalım!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Kayıt yapmak için istenilenleri doldurun",
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
                              boxShadow: [
                                DecorationConstants.instance.boxshadow
                              ]),
                          child: TextField(
                            autocorrect: false,
                            onChanged: (text) {
                              username = text.toString();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Kullanıcı Adı"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  RadiusConstants.instance.circularBorder15,
                              boxShadow: [
                                DecorationConstants.instance.boxshadow
                              ]),
                          child: TextField(
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
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  RadiusConstants.instance.circularBorder10,
                              boxShadow: [
                                DecorationConstants.instance.boxshadow
                              ]),
                          child: TextField(
                            autocorrect: false,
                            onChanged: (text) {
                              firstName = text.toString();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Ad"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  RadiusConstants.instance.circularBorder10,
                              boxShadow: [
                                DecorationConstants.instance.boxshadow
                              ]),
                          child: TextField(
                            autocorrect: false,
                            onChanged: (text) {
                              lastName = text.toString();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Soyad"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  RadiusConstants.instance.circularBorder10,
                              boxShadow: [
                                DecorationConstants.instance.boxshadow
                              ]),
                          child: TextField(
                            autocorrect: false,
                            onChanged: (text) {
                              mail = text.toString();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Mail"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  RadiusConstants.instance.circularBorder10,
                              boxShadow: [
                                DecorationConstants.instance.boxshadow
                              ]),
                          child: TextField(
                            autocorrect: false,
                            onChanged: (text) {
                              phoneNum = text.toString();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Telefon Numarası"),
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
                              boxShadow: [
                                DecorationConstants.instance.boxshadow
                              ]),
                          child: registerButton(context),
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

  Widget registerButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await dbServices.register(
            username, password, mail, firstName, lastName, phoneNum);
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text("Başarılı!"),
            content: Text(
                "Kullanıcı başarıyla oluşturuldu, giriş sayfasına yönlendiriliyorsunuz."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text("Tamam"))
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: DecorationConstants.instance.colorBlue,
        shape: RoundedRectangleBorder(
          borderRadius: RadiusConstants.instance.circularBorder30,
        ),
      ),
      child: Center(
        child: Text(
          "Kayıt Ol",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
