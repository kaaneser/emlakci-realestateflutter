import 'dart:io';
import 'dart:ui';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vtysproje/db/database_services.dart';
import 'package:vtysproje/views/initexample.dart';

class ilanolustur extends StatefulWidget {
  @override
  _ilanolusturState createState() => _ilanolusturState();
}

class _ilanolusturState extends State<ilanolustur> {
  Map<String, dynamic> addingData = Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
    addingData["haveElectric"] = 0;
    addingData["haveWater"] = 0;
    addingData["haveGas"] = 0;
    addingData["haveNet"] = 0;
  }

  File _image = File("");
  final picker = ImagePicker();

  Future<void> _resimEkle() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        addingData["photo"] = "";
      });
    }
  }

  int _index = 0; // İLAN TİPİ
  int _index4 = 0; // KONUT PROP
  int _index5 = 0; // TİCARİ PROP
  int _index6 = 0; // ARAZİ PROP
  int _index2 = 0; // SATILIK VS.
  int _index3 = 0; // ORTAK KATMAN
  bool? selected = false;
  bool? selected1 = false;
  bool? selected2 = false;
  bool? selected3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                    padding: EdgeInsets.fromLTRB(25, 50, 30, 5),
                    child: Row(children: <Widget>[
                      Container(
                        height: 50,
                        width: 30,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 25,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            postData = [];
                            await DatabaseServices().getPosts("", "", "", 0);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ]),
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 40)),
                      Text("İlan Oluşturalım!",
                          style: TextStyle(
                            fontSize: 27,
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
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                      "İlan Tipi",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _index == 1
                                          ? Colors.lightBlueAccent[100]
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.home,
                                          size: 35,
                                          color: _index == 1
                                              ? Colors.white
                                              : Colors.grey[500],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'KONUT',
                                          style: TextStyle(
                                            color: _index == 1
                                                ? Colors.white
                                                : Colors.grey[500],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    addingData["postType"] = 1;
                                    setState(() {
                                      _index = 1;
                                    });
                                  }),
                            ),
                          ), //KONUT
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _index == 2
                                          ? Colors.lightBlueAccent[100]
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.business_rounded,
                                          size: 35,
                                          color: _index == 2
                                              ? Colors.white
                                              : Colors.grey[500],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'TİCARİ',
                                          style: TextStyle(
                                            color: _index == 2
                                                ? Colors.white
                                                : Colors.grey[500],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    addingData["postType"] = 2;
                                    setState(() {
                                      _index = 2;
                                    });
                                  }),
                            ),
                          ), //TİCARİ
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _index == 3
                                          ? Colors.lightBlueAccent[100]
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.landscape,
                                          size: 35,
                                          color: _index == 3
                                              ? Colors.white
                                              : Colors.grey[500],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'ARAZİ',
                                          style: TextStyle(
                                            color: _index == 3
                                                ? Colors.white
                                                : Colors.grey[500],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    addingData["postType"] = 3;
                                    setState(() {
                                      _index = 3;
                                    });
                                  }),
                            ),
                          ), //ARAZİ
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                              child: Container(
                                  width: 95,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: _index2 == 1
                                        ? Colors.lightBlueAccent[100]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Satılık',
                                        style: TextStyle(
                                          color: _index2 == 1
                                              ? Colors.white
                                              : Colors.grey[500],
                                          fontWeight: _index2 == 1
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )),
                              onTap: () {
                                addingData["postStatus"] = 2;
                                setState(() {
                                  _index2 = 1;
                                });
                              }), // SATILIK
                          SizedBox(width: 5),
                          GestureDetector(
                              child: Container(
                                  width: 95,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: _index2 == 2
                                        ? Colors.lightBlueAccent[100]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Kiralık',
                                        style: TextStyle(
                                          color: _index2 == 2
                                              ? Colors.white
                                              : Colors.grey[500],
                                          fontWeight: _index2 == 2
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )),
                              onTap: () {
                                addingData["postStatus"] = 1;
                                setState(() {
                                  _index2 = 2;
                                });
                              }), // KİRALIK
                          SizedBox(width: 5),
                          GestureDetector(
                              child: Container(
                                  width: 135,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: _index2 == 3
                                        ? Colors.lightBlueAccent[100]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Günlük Kiralık',
                                        style: TextStyle(
                                          color: _index2 == 3
                                              ? Colors.white
                                              : Colors.grey[500],
                                          fontWeight: _index2 == 3
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )),
                              onTap: () {
                                addingData["postStatus"] = 3;
                                setState(() {
                                  _index2 = 3;
                                });
                              }), // GÜNLÜK KİRALIK
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                if (_index == 1)
                  konutProp(context)
                else if (_index == 2)
                  ticariProp(context)
                else if (_index == 3)
                  araziProp(context),

                Column(
                  children: [
                    headName('İlan Başlığı'),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 5, bottom: 31),
                      child: Row(
                        children: [
                          GestureDetector(
                              child: Container(
                                  width: 355,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: _index3 == 1
                                        ? Colors.lightBlueAccent[100]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextField(
                                          onChanged: (text) {
                                            addingData["postHead"] = text;
                                          },
                                          maxLength: 17,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(25),
                                              ),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: _index3 == 1
                                                ? Colors.white
                                                : Colors.grey[500],
                                            fontWeight: _index3 == 1
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              onTap: () {
                                setState(() {
                                  _index3 = 1;
                                });
                              }), // İLAN BAŞLIĞI
                        ],
                      ),
                    ),
                    headName('Açıklama'),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 5, bottom: 31),
                      child: Row(
                        children: [
                          GestureDetector(
                              child: Container(
                                  width: 355,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    color: _index3 == 2
                                        ? Colors.lightBlueAccent[100]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextField(
                                          onChanged: (text) {
                                            addingData["desc"] = text;
                                          },
                                          textInputAction: TextInputAction.done,
                                          minLines: 1,
                                          maxLines: 7,
                                          maxLength: 150,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 50, 10, 0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(25),
                                              ),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: _index3 == 2
                                                ? Colors.white
                                                : Colors.grey[500],
                                            fontWeight: _index3 == 2
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              onTap: () {
                                setState(() {
                                  _index3 = 2;
                                });
                              }), // AÇIKLAMA
                        ],
                      ),
                    ),
                    headName('Fiyat'),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 5, bottom: 31),
                      child: Row(
                        children: [
                          GestureDetector(
                              child: Container(
                                  width: 200,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: _index3 == 3
                                        ? Colors.lightBlueAccent[100]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextField(
                                          onChanged: (text) {
                                            addingData["price"] = text;
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: "₺",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[500]),
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(25),
                                              ),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: _index3 == 3
                                                ? Colors.white
                                                : Colors.grey[500],
                                            fontWeight: _index3 == 3
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              onTap: () {
                                setState(() {
                                  _index3 = 3;
                                });
                              }), // FİYAT
                        ],
                      ),
                    ),
                    headName('Konum'),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 5, bottom: 31),
                      child: Row(
                        children: [
                          GestureDetector(
                              child: Container(
                                  width: 250,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: _index3 == 4
                                        ? Colors.lightBlueAccent[100]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextField(
                                          onChanged: (text) {
                                            addingData["city"] = text;
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(25),
                                              ),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: _index3 == 4
                                                ? Colors.white
                                                : Colors.grey[500],
                                            fontWeight: _index3 == 4
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              onTap: () {
                                setState(() {
                                  _index3 = 4;
                                });
                              }), // KONUM
                        ],
                      ),
                    ),
                    headName('Altyapı Durumu'),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 5, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                              child: Container(
                                  width: 160,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    color: _index3 == 5
                                        ? Colors.lightBlueAccent[100]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Icon(
                                        Icons.electrical_services,
                                        size: 40,
                                        color: _index3 == 5
                                            ? Colors.white
                                            : Colors.grey[500],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Elektrik',
                                        style: TextStyle(
                                          color: _index3 == 5
                                              ? Colors.white
                                              : Colors.grey[500],
                                          fontWeight: _index3 == 5
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                      ),
                                      CheckboxListTile(
                                        activeColor: _index3 == 5
                                            ? Colors.blue
                                            : Colors.grey[200],
                                        checkColor: _index3 == 5
                                            ? Colors.white
                                            : Colors.grey[500],
                                        contentPadding:
                                            EdgeInsets.fromLTRB(0, 0, 55, 0),
                                        value: selected,
                                        onChanged: (value) {
                                          if (value == true)
                                            addingData["haveElectric"] = 1;
                                          else
                                            addingData["haveElectric"] = 0;
                                          setState(() {
                                            selected = value;
                                          });
                                        },
                                      )
                                    ],
                                  )),
                              onTap: () {
                                setState(() {
                                  _index3 = 5;
                                });
                              }), // ELEKTRİK
                          SizedBox(width: 5),
                          GestureDetector(
                              child: Container(
                                  width: 160,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    color: _index3 == 6
                                        ? Colors.lightBlueAccent[100]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Icon(
                                        Icons.invert_colors_on_sharp,
                                        size: 40,
                                        color: _index3 == 6
                                            ? Colors.white
                                            : Colors.grey[500],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Su',
                                        style: TextStyle(
                                          color: _index3 == 6
                                              ? Colors.white
                                              : Colors.grey[500],
                                          fontWeight: _index3 == 6
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                      ),
                                      CheckboxListTile(
                                        activeColor: _index3 == 6
                                            ? Colors.blue
                                            : Colors.grey[200],
                                        checkColor: _index3 == 6
                                            ? Colors.white
                                            : Colors.grey[500],
                                        contentPadding:
                                            EdgeInsets.only(right: 55),
                                        value: selected1,
                                        onChanged: (value) {
                                          if (value == true)
                                            addingData["haveWater"] = 1;
                                          else
                                            addingData["haveWater"] = 0;
                                          setState(() {
                                            selected1 = value;
                                          });
                                        },
                                      )
                                    ],
                                  )),
                              onTap: () {
                                setState(() {
                                  _index3 = 6;
                                });
                              }), //SU
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 0, bottom: 31),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                              child: Container(
                                  width: 160,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    color: _index3 == 7
                                        ? Colors.lightBlueAccent[100]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Icon(
                                        Icons.local_gas_station,
                                        size: 40,
                                        color: _index3 == 7
                                            ? Colors.white
                                            : Colors.grey[500],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Doğalgaz',
                                        style: TextStyle(
                                          color: _index3 == 7
                                              ? Colors.white
                                              : Colors.grey[500],
                                          fontWeight: _index3 == 7
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                      ),
                                      CheckboxListTile(
                                        activeColor: _index3 == 7
                                            ? Colors.blue
                                            : Colors.grey[200],
                                        checkColor: _index3 == 7
                                            ? Colors.white
                                            : Colors.grey[500],
                                        contentPadding:
                                            EdgeInsets.only(right: 55),
                                        value: selected2,
                                        onChanged: (value) {
                                          if (value == true)
                                            addingData["haveGas"] = 1;
                                          else
                                            addingData["haveGas"] = 0;
                                          setState(() {
                                            selected2 = value;
                                          });
                                        },
                                      )
                                    ],
                                  )),
                              onTap: () {
                                setState(() {
                                  _index3 = 7;
                                });
                              }), //DOĞALGAZ
                          SizedBox(width: 5),
                          GestureDetector(
                              child: Container(
                                  width: 160,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    color: _index3 == 8
                                        ? Colors.lightBlueAccent[100]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Icon(
                                        Icons.network_check,
                                        size: 40,
                                        color: _index3 == 8
                                            ? Colors.white
                                            : Colors.grey[500],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'İnternet',
                                        style: TextStyle(
                                          color: _index3 == 8
                                              ? Colors.white
                                              : Colors.grey[500],
                                          fontWeight: _index3 == 8
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                      ),
                                      CheckboxListTile(
                                        activeColor: _index3 == 8
                                            ? Colors.blue
                                            : Colors.grey[200],
                                        checkColor: _index3 == 8
                                            ? Colors.white
                                            : Colors.grey[500],
                                        contentPadding:
                                            EdgeInsets.only(right: 55),
                                        value: selected3,
                                        onChanged: (value) {
                                          if (value == true)
                                            addingData["haveNet"] = 1;
                                          else
                                            addingData["haveNet"] = 0;
                                          setState(() {
                                            selected3 = value;
                                          });
                                        },
                                      )
                                    ],
                                  )),
                              onTap: () {
                                setState(() {
                                  _index3 = 8;
                                });
                              }), // İNTERNET
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(children: [
                      Center(
                        child: FloatingActionButton(
                          onPressed: () {
                            _resimEkle();
                          },
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 355,
                        height: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3),
                            ),
                          ],
                        ),
                        child: _image.path != ""
                            ? Image.file(_image, fit: BoxFit.cover)
                            : Text(
                                'Lütfen fotoğraf ekleyin.',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey[500],
                                ),
                              ),
                      )
                    ]),
                    SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                      // onTap: (addingData["postType"] == 1 &&
                      //             addingData.length == 15) ||
                      //         (addingData["postType"] == 2 &&
                      //             addingData.length == 12) ||
                      //         (addingData["postType"] == 3 &&
                      //             addingData.length == 13)
                      onTap: 1 == 1
                          ? () async {
                              print("Bastı");
                              print(addingData);
                              print(addingData.length);
                              await upload();
                              await DatabaseServices().addPost(addingData);
                              postData = [];
                              await DatabaseServices().getPosts("", "", "", 0);
                              Navigator.pop(context);
                            }
                          : null,
                      child: Container(
                          width: 370,
                          height: 80,
                          decoration: BoxDecoration(
                            color: (addingData["postType"] == 1 &&
                                        addingData.length == 15) ||
                                    (addingData["postType"] == 2 &&
                                        addingData.length == 12) ||
                                    (addingData["postType"] == 3 &&
                                        addingData.length == 13)
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'KAYDET!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              )
                            ],
                          )),
                    ), // KAYDET BUTONU
                  ],
                ), //ORTAK KATMAN!!
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget headName(String text) {
    return Row(
      children: [
        Padding(padding: EdgeInsets.only(left: 10)),
        Text(
          "$text",
          style: TextStyle(
            fontSize: 22,
            color: Colors.blue[600],
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget konutProp(BuildContext context) {
    return Column(
      children: [
        headName('Konut Bilgileri'),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: _index4 == 1
                            ? Colors.lightBlueAccent[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.king_bed_outlined,
                            size: 40,
                            color:
                                _index4 == 1 ? Colors.white : Colors.grey[500],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Yatak Odası',
                            style: TextStyle(
                              color: _index4 == 1
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontWeight: _index4 == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: TextField(
                              onChanged: (text) {
                                addingData["bedrooms"] = text;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 22),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 17,
                                color: _index4 == 1
                                    ? Colors.white
                                    : Colors.grey[500],
                                fontWeight: _index4 == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      )),
                  onTap: () {
                    setState(() {
                      _index4 = 1;
                    });
                  }), // YATAK ODASI
              SizedBox(width: 5),
              GestureDetector(
                  child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: _index4 == 2
                            ? Colors.lightBlueAccent[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.bathtub_outlined,
                            size: 40,
                            color:
                                _index4 == 2 ? Colors.white : Colors.grey[500],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Banyo Sayısı',
                            style: TextStyle(
                              color: _index4 == 2
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontWeight: _index4 == 2
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: TextField(
                              onChanged: (text) {
                                addingData["bathrooms"] = text;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 22),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 17,
                                color: _index4 == 2
                                    ? Colors.white
                                    : Colors.grey[500],
                                fontWeight: _index4 == 2
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      )),
                  onTap: () {
                    setState(() {
                      _index4 = 2;
                    });
                  }), //BANYO SAYISI
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 31),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: _index4 == 3
                            ? Colors.lightBlueAccent[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.kitchen_outlined,
                            size: 40,
                            color:
                                _index4 == 3 ? Colors.white : Colors.grey[500],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Mutfak Sayısı',
                            style: TextStyle(
                              color: _index4 == 3
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontWeight: _index4 == 3
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: TextField(
                              onChanged: (text) {
                                addingData["kitchens"] = text;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 22),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 17,
                                color: _index4 == 3
                                    ? Colors.white
                                    : Colors.grey[500],
                                fontWeight: _index4 == 3
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      )),
                  onTap: () {
                    setState(() {
                      _index4 = 3;
                    });
                  }), //MUTFAK SAYISI
              SizedBox(width: 5),
              GestureDetector(
                  child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: _index4 == 4
                            ? Colors.lightBlueAccent[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home_outlined,
                            size: 40,
                            color:
                                _index4 == 4 ? Colors.white : Colors.grey[500],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'm²',
                            style: TextStyle(
                              color: _index4 == 4
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontWeight: _index4 == 4
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: TextField(
                              onChanged: (text) {
                                addingData["pitch"] = text;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 17,
                                color: _index4 == 4
                                    ? Colors.white
                                    : Colors.grey[500],
                                fontWeight: _index4 == 4
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      )),
                  onTap: () {
                    setState(() {
                      _index4 = 4;
                    });
                  }), // m²
            ],
          ),
        ),
      ],
    );
  }

  Widget ticariProp(BuildContext context) {
    return Column(
      children: [
        headName('Ticari Bilgileri'),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 31),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: _index5 == 1
                            ? Colors.lightBlueAccent[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.house_siding,
                            size: 40,
                            color:
                                _index5 == 1 ? Colors.white : Colors.grey[500],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Bölüm Sayısı',
                            style: TextStyle(
                              color: _index5 == 1
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontWeight: _index5 == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: TextField(
                              onChanged: (text) {
                                addingData["sectionNumber"] = text;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 22),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 17,
                                color: _index5 == 1
                                    ? Colors.white
                                    : Colors.grey[500],
                                fontWeight: _index5 == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      )),
                  onTap: () {
                    setState(() {
                      _index5 = 1;
                    });
                  }), //BÖLÜM SAYISI
              SizedBox(width: 5),
              GestureDetector(
                  child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: _index5 == 2
                            ? Colors.lightBlueAccent[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home_outlined,
                            size: 40,
                            color:
                                _index5 == 2 ? Colors.white : Colors.grey[500],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'm²',
                            style: TextStyle(
                              color: _index5 == 2
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontWeight: _index5 == 2
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: TextField(
                              onChanged: (text) {
                                addingData["pitch"] = text;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 17,
                                color: _index5 == 2
                                    ? Colors.white
                                    : Colors.grey[500],
                                fontWeight: _index5 == 2
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      )),
                  onTap: () {
                    setState(() {
                      _index5 = 2;
                    });
                  }), // m²
            ],
          ),
        ),
      ],
    );
  }

  Widget araziProp(BuildContext context) {
    return Column(
      children: [
        headName('Arazi Bilgileri'),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: _index6 == 1
                            ? Colors.lightBlueAccent[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.landscape_outlined,
                            size: 40,
                            color:
                                _index6 == 1 ? Colors.white : Colors.grey[500],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'İmar Durumu',
                            style: TextStyle(
                              color: _index6 == 1
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontWeight: _index6 == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              onChanged: (text) {
                                addingData["zoning"] = 1;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 17,
                                color: _index6 == 1
                                    ? Colors.white
                                    : Colors.grey[500],
                                fontWeight: _index6 == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      )),
                  onTap: () {
                    setState(() {
                      _index6 = 1;
                    });
                  }), // İMAR DURUMU
              SizedBox(width: 5),
              GestureDetector(
                  child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: _index6 == 2
                            ? Colors.lightBlueAccent[100]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.assignment_turned_in_outlined,
                            size: 40,
                            color:
                                _index6 == 2 ? Colors.white : Colors.grey[500],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Tapu Durumu',
                            style: TextStyle(
                              color: _index6 == 2
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontWeight: _index6 == 2
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              onChanged: (text){
                                addingData["titleDeed"] = text;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 17,
                                color: _index6 == 2
                                    ? Colors.white
                                    : Colors.grey[500],
                                fontWeight: _index6 == 2
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      )),
                  onTap: () {
                    setState(() {
                      _index6 = 2;
                    });
                  }), //TAPU DURUMU
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 31),
          child: Center(
            child: GestureDetector(
                child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: _index6 == 3
                          ? Colors.lightBlueAccent[100]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.landscape,
                          size: 40,
                          color: _index6 == 3 ? Colors.white : Colors.grey[500],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'm²',
                          style: TextStyle(
                            color:
                                _index6 == 3 ? Colors.white : Colors.grey[500],
                            fontWeight: _index6 == 3
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                            onChanged: (text){
                              addingData["pitch"] = text;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 17,
                              color: _index6 == 3
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontWeight: _index6 == 3
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    )),
                onTap: () {
                  setState(() {
                    _index6 = 3;
                  });
                }), // m²
          ),
        ),
      ],
    );
  }

  Widget showSnackbar() {
    return SnackBar(
        content: Text("İlan oluşturuldu."),
        action: SnackBarAction(
          label: "İlan başarıyla oluşturuldu.",
          onPressed: () {},
        ));
  }

  Future upload() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularProgressIndicator(),
                  Text("İlan Oluşturuluyor...")
                ],
              ),
            ),
          );
        });
    try {
      final res =
          await cloudinary.uploadFile(CloudinaryFile.fromFile(_image.path));
      addingData["photo"] = res.toMap()["url"];
      print(res.toMap()["url"]);
    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
      addingData["photo"] = "https://res.cloudinary.com/hvrgbmjkq/image/upload/v1619985956/house_pzaznq.jpg";
    }
    Navigator.pop(context);
  }
}
