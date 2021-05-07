import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtysproje/db/database_services.dart';
import 'package:vtysproje/views/profil.dart';

class ProfiliDuzenle extends StatefulWidget {
  @override
  _ProfiliDuzenleState createState() => _ProfiliDuzenleState();
}

class _ProfiliDuzenleState extends State<ProfiliDuzenle> {
  bool showPassW = false;
  Map<String, String> updatedData = new Map<String, String>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 5),
                child: Row(children: <Widget>[
                  Container(
                    height: 50,
                    width: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ]),
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 40)),
                  Text("Hesap Bilgilerim",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      )),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(children: <Widget>[
            textYapisi('Ad', '${userData["firstName"]}', false, updatedData,
                "firstName"),
            textYapisi('Soyad', '${userData["lastName"]}', false, updatedData,
                "lastName"),
            textYapisi('Kullanıcı Adı', '${userData["username"]}', false,
                updatedData, "username"),
            textYapisi('Telefon Numarası', '${userData["phoneNumber"]}', false,
                updatedData, "phoneNumber"),
            textYapisi(
                'E-mail', '${userData["mail"]}', false, updatedData, "mail"),
            textYapisi('Şifre', '*********', true, updatedData, "pass"),
            SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 65, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("İPTAL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 45),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () async {
                      await DatabaseServices()
                          .updateUser(updatedData, userData["userId"]);
                      userPostData = [];
                      await DatabaseServices()
                          .getUserPosts(userData["userId"])
                          .whenComplete(() {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ProfilSayfasi()));
                      });
                    },
                    child: Text(
                      "KAYDET",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget textYapisi(String text, String text2, bool passwordField,
      Map<String, String> updatedData, String row) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 25, 50, 0),
      child: TextField(
          onSubmitted: (val) {
            updatedData[row] = val;
          },
          obscureText: passwordField ? showPassW : false,
          decoration: InputDecoration(
            suffixIcon: passwordField
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassW = !showPassW;
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: '$text',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: '${text2}',
            hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlueAccent[100]),
          )),
    );
  }
}
