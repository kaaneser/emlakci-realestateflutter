import 'dart:ui';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtysproje/constants/decoration_constants.dart';
import 'package:vtysproje/db/database_services.dart';
import 'package:vtysproje/views/detailview.dart';
import 'package:vtysproje/views/profiledit.dart';

OpenContainer ilan(
    String text, String text2, String assetname, int postId, int postType) {
  return OpenContainer(
    transitionDuration: Duration(milliseconds: 1000),
    openBuilder: (context, Object) {
      clickedPostId = postId;
      List postDetails = [];
      postDetails.add(postId);
      postDetails.add(postType);

      return DetailView(postDetails: postDetails);
    },
    closedBuilder: (context, VoidCallback openContainer) => Container(
      padding: EdgeInsets.only(left: 15),
      width: 167,
      height: 230,
      child: Stack(
        children: <Widget>[
          Container(
            clipBehavior: Clip.antiAlias,
            width: 167,
            height: 230,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black]),
              boxShadow: [DecorationConstants.instance.boxshadow],
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('$assetname'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 3,
            right: 1,
            child: FloatingActionButton(
              onPressed: () {},
              mini: true,
              backgroundColor: DecorationConstants.instance.colorBlue,
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 22,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$text',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.white,
                    ),
                    Text('$text2',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

String nameField = "${userData["firstName"]} ${userData["lastName"]}";
String mailField = userData["mail"];

class ProfilSayfasi extends StatefulWidget {
  @override
  _ProfilSayfasiState createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  var itemCount = userPostData.length;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(25, 45, 0, 0),
            child: Row(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 30,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 64,
                backgroundColor: Colors.lightBlueAccent,
                child: CircleAvatar(
                  backgroundColor: DecorationConstants.instance.colorBlue,
                  foregroundColor: Colors.white,
                  radius: 60,
                  child: Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "${userData["firstName"]} ${userData["lastName"]}",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          SizedBox(height: 10),
          Text(
            userData["mail"],
          ),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "İLANLARIM",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                      width: 155,
                      child: Divider(
                        thickness: 2,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 250,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (context, i) {
                return ilan(
                    userPostData[i]["postHead"],
                    userPostData[i]["city"],
                    'assets/images/house.jpeg',
                    userPostData[i]["postId"],
                    userPostData[i]["postType"]);
              },
            ),
          ),
          SizedBox(height: 15),
          profilMenu('Hesap Bilgilerim', Icons.account_circle, true, context),
          SizedBox(height: 15),
          profilMenu('Çıkış', Icons.exit_to_app, false, context),
        ],
      ),
    );
  }

  GestureDetector profilMenu(
      String text, IconData icon, bool arrowShown, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text == 'Hesap Bilgilerim') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfiliDuzenle()));
        } else if (text == 'Çıkış') {
          Navigator.pop(context);
          userData = [];
          isLoggedIn = false;
          
        }
      },
      child: Container(
        height: 50,
        width: 325,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Icon(
                    icon,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '$text',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            arrowShown
                ? Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 35,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
