import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtysproje/constants/decoration_constants.dart';
import 'package:vtysproje/constants/radius_constants.dart';
import 'package:vtysproje/db/database_services.dart';
import 'package:vtysproje/views/addpostview.dart';
import 'package:vtysproje/views/profil.dart';
import 'package:vtysproje/views/filterview.dart';
import 'package:vtysproje/views/detailview.dart';
import 'package:vtysproje/views/loginview.dart';

String minPrice = "", maxPrice = "", statusDetail = "";

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool isFiltered = false;
  int limit = 5;
  DatabaseServices dbService = new DatabaseServices();
  var itemCount = postData.length;
  bool isSearching = false;
  List searchedList = [];
  TextEditingController textEditingController = TextEditingController();
  int postType = 0;
  String memory = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DecorationConstants.instance.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (isLoggedIn == true) {
                        userPostData = [];
                        await dbService.getUserPosts(userData["userId"]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilSayfasi())).then((value){
                                  setState(() {
                                    isLoggedIn = isLoggedIn;
                                    userData = userData;
                                  });
                                });
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()));
                      }
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: DecorationConstants.instance.colorBlue,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.person),
                    ),
                  ),
                  Container(
                    padding:
                        isLoggedIn == false ? EdgeInsets.only(right: 70) : null,
                    child: Text(
                      "Emlakçı",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  Visibility(
                    visible: isLoggedIn == true ? true : false,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ilanolustur()))
                            .then((val) async {
                          await refreshList();
                        });
                      },
                      icon: Icon(Icons.add_circle),
                      iconSize: 50,
                      color: DecorationConstants.instance.colorBlue,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: searchBar(),
                  ),
                  DecorationConstants.instance.sizedBoxw10,
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        isFiltered == false
                            ? filterModal()
                            : showDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: Text("Sıfırla"),
                                  content: Text(
                                      "Filtreleri sıfırlamak istiyor musunuz?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          statusDetail = "";
                                          minPrice = "";
                                          maxPrice = "";
                                          postData = [];
                                          await DatabaseServices().getPosts(
                                              statusDetail,
                                              minPrice,
                                              maxPrice,
                                              postType);
                                          setState(() {
                                            Navigator.pop(context);
                                            isFiltered = false;
                                            itemCount = postData.length;
                                          });
                                        },
                                        child: Text("Evet")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Hayır"))
                                  ],
                                ),
                              );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              RadiusConstants.instance.circularBorder15,
                          color: DecorationConstants.instance.colorBlue,
                        ),
                        height: 32,
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  propertyFilterCard("house", "Konut", 1),
                  propertyFilterCard("shop", "Ticari", 2),
                  propertyFilterCard("land", "Arazi", 3)
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 100,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: RefreshIndicator(
                  key: refreshKey,
                  onRefresh: refreshList,
                  child: isSearching == false
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: itemCount,
                          itemBuilder: (context, i) {
                            return propertyCard(
                                postData[i]["postHead"],
                                postData[i]["city"],
                                "${postData[i]["price"]}TL",
                                postData[i]["postStatus"],
                                postData[i]["postId"],
                                postData[i]["photo"],
                                postData[i]["postType"],
                                i);
                          },
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: searchedList.length,
                          itemBuilder: (context, i) {
                            return propertyCard(
                                searchedList[i]["postHead"],
                                searchedList[i]["city"],
                                "${searchedList[i]["price"]}TL",
                                searchedList[i]["postStatus"],
                                searchedList[i]["postId"],
                                searchedList[i]["photo"],
                                searchedList[i]["postType"],
                                i);
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector propertyFilterCard(String photo, String name, int type) {
    return GestureDetector(
      onTap: isFiltered == false
          ? () async {
              if (memory != name) {
                postType = type;
                postData = [];
                await DatabaseServices()
                    .getPosts(statusDetail, minPrice, maxPrice, postType);
                setState(() {
                  itemCount = postData.length;
                  memory = name;
                });
              } else {
                postType = 0;
                postData = [];
                await DatabaseServices()
                    .getPosts(statusDetail, minPrice, maxPrice, postType);
                setState(() {
                  itemCount = postData.length;
                  memory = "";
                });
              }
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage("assets/images/$photo.jpeg"),
              fit: BoxFit.cover),
          boxShadow: [DecorationConstants.instance.boxshadow],
        ),
        height: name == memory ? 100 : 120,
        width: name == memory ? 100 : 120,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }

  TextField searchBar() {
    return TextField(
      controller: textEditingController,
      onChanged: (value) {
        if (textEditingController.text.trim().length != 0) {
          setState(() {
            searchedList.clear();
            isSearching = true;
          });
          value = value.toLowerCase();
          for (var i = 0; i < postData.length; i++) {
            if (postData[i]["postHead"]
                .toString()
                .toLowerCase()
                .contains(value)) {
              searchedList.add(postData[i]);
            }
          }
        } else {
          setState(() {
            isSearching = false;
          });
        }
      },
      style: TextStyle(
          fontSize: 28,
          height: 1,
          color: Colors.black,
          fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: "Arama Yap",
        hintStyle: TextStyle(
          fontSize: 28,
          color: Colors.black45,
        ),
        enabledBorder: DecorationConstants.instance.searchInputBorder,
        focusedBorder: DecorationConstants.instance.searchInputBorder,
        border: DecorationConstants.instance.searchInputBorder,
        suffixIcon: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(
            Icons.search,
            color: Colors.black45,
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget propertyCard(String propertyHead, String location, String price,
      String type, int postId, String photoUrl, int postType, int indice) {
    return OpenContainer(
      onClosed: (context) async {
        await refreshList();
      },
      transitionDuration: Duration(milliseconds: 1000),
      openBuilder: (context, object) {
        clickedPostId = indice;
        List postDetails = [postId, postType];
        postDetails.add(postId);
        postDetails.add(postType);

        return DetailView(postDetails: postDetails);
      },
      closedBuilder: (context, VoidCallback openContainer) => Card(
        elevation: 5,
        shadowColor: Colors.grey,
        borderOnForeground: false,
        margin: EdgeInsets.only(bottom: 24),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                photoUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        propertyHead,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.21 - 3.6,
                      alignment: Alignment.centerRight,
                      child: Text(
                        price,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text(
                          location,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      type,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void filterModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: RadiusConstants.instance.circular30,
            topRight: RadiusConstants.instance.circular30,
          ),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                FilterView(),
              ],
            ),
          );
        }).whenComplete(() async {
      isFiltered = true;
      postData = [];
      await DatabaseServices()
          .getPosts(statusDetail, minPrice, maxPrice, postType);
      setState(() {
        itemCount = postData.length;
      });
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    postData = [];
    await DatabaseServices()
        .getPosts(statusDetail, minPrice, maxPrice, postType);
    setState(() {
      itemCount = postData.length;
    });
  }
}
