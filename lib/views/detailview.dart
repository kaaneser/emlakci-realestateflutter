import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:vtysproje/db/database_services.dart';

import '../constants/decoration_constants.dart';

class DetailView extends StatefulWidget {
  final postDetails;

  const DetailView({Key? key, this.postDetails}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  Future<void> callProperty(String tel) async {
    if (await canLaunch(tel)) {
      await launch(tel);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  void initState() {
    isLoaded = false;
    getDetail();
    super.initState();
  }

  void getDetail() async {
    await DatabaseServices().getPostDetails(
        postData[clickedPostId]["postId"], postData[clickedPostId]["postType"]);
    setState(() {
      isLoaded = true;
    });
  }

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoaded == false
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  height: size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(postData[clickedPostId]["photo"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white54,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios_new),
                                color: Colors.black,
                                iconSize: 24,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            if (isLoggedIn == true)
                              if (userData["userId"] ==
                                  postDetailData["ownerId"])
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white54,
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.black,
                                    iconSize: 24,
                                    onPressed: () async {
                                      await DatabaseServices().deletePost(
                                          postData[clickedPostId]["postId"],
                                          postData[clickedPostId]["postType"]);
                                      Navigator.pop(context);
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                          title: Text("Silindi"),
                                          content: Text("İlanınız silindi."),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Tamam"))
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: size.height * 0.65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 20, left: 24, right: 24, top: 10),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Icon(Icons.person),
                                      radius: 25,
                                      backgroundColor: DecorationConstants
                                          .instance.colorBlue,
                                      foregroundColor: DecorationConstants
                                          .instance.backgroundColor,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      postDetailData["ownerName"].toString() +
                                          " " +
                                          postDetailData["ownerSurname"]
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      DecorationConstants.instance.colorBlue,
                                  child: IconButton(
                                    onPressed: () {
                                      callProperty(
                                          'tel:${postDetailData["phoneNum"]}');
                                    },
                                    icon: Icon(Icons.phone),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: 10, left: 24, right: 24),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.black54,
                              ),
                              Text(
                                postData[clickedPostId]["city"],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                postData[clickedPostId]["postHead"],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    )),
                                child: Text(
                                  "${postData[clickedPostId]["price"]}TL",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 30, top: 10, right: 30),
                          child: detailsRow(),
                        ),
                        Divider(
                          height: 20,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 10, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Açıklama",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text("${postDetailData["desc"]}"),
                              SizedBox(height: 10),
                              Text(
                                "Altyapı Durumu",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              DecorationConstants.instance.sizedBoxh10,
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10, left: 10, right: 10),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      additionalInfoContainer("Doğalgaz",
                                          postDetailData["haveGas"]),
                                      additionalInfoContainer(
                                          "Su", postDetailData["haveWater"]),
                                      additionalInfoContainer("Elektrik",
                                          postDetailData["haveElectric"]),
                                      additionalInfoContainer(
                                          "İnternet", postDetailData["haveNet"])
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Widget additionalInfoContainer(String value, int ifExists) {
  return Row(
    children: [
      Icon(
        ifExists == 1 ? Icons.check : Icons.clear,
        color: Colors.blue,
      ),
      Text(value),
    ],
  );
}

Widget detailsRow() {
  if (postData[clickedPostId]["postType"] == 1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Icon(
              Icons.bed,
              color: Colors.blue,
              size: 30,
            ),
            Text(
              "${postDetailData["bedrooms"]} Yatak Odası",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.bathtub_outlined,
              color: Colors.blue,
              size: 30,
            ),
            Text(
              "${postDetailData["bathrooms"]} Tuvalet",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.kitchen,
              color: Colors.blue,
              size: 30,
            ),
            Text(
              "${postDetailData["kitchens"]} Mutfak",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "m²",
              style: TextStyle(fontSize: 25, color: Colors.blue),
            ),
            Text(
              "${postData[clickedPostId]["pitch"]} m²",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  } else if (postData[clickedPostId]["postType"] == 2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(
              Icons.house_siding,
              color: Colors.blue,
              size: 30,
            ),
            Text(
              "${postDetailData["sectionNumber"]} Bölüm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "m²",
              style: TextStyle(fontSize: 25, color: Colors.blue),
            ),
            Text(
              "${postData[clickedPostId]["pitch"]} m²",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  } else if (postData[clickedPostId]["postType"] == 3) {
    String zoningStatus = "", titleDeed = "";
    if (postDetailData["zoning"] == 1)
      zoningStatus = "İmara açık";
    else
      zoningStatus = "İmara kapalı";

    if (postDetailData["titleDeed"] == 1) {
      titleDeed = "Tapu bulunur";
    } else {
      titleDeed = "Tapu bulunmaz";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Icon(
              Icons.landscape,
              color: Colors.blue,
              size: 30,
            ),
            Text(
              zoningStatus,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.task,
              color: Colors.blue,
              size: 30,
            ),
            Text(
              titleDeed,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "m²",
              style: TextStyle(fontSize: 25, color: Colors.blue),
            ),
            Text(
              "${postData[clickedPostId]["pitch"]} Dönüm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
  return Row();
}
