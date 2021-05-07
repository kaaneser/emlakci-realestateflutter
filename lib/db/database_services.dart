import 'package:vtysproje/models/housemodel.dart';
import 'package:vtysproje/models/landmodel.dart';
import 'package:vtysproje/models/postmodel.dart';
import 'package:vtysproje/models/shopmodel.dart';
import 'package:vtysproje/models/usermodel.dart';
import 'database_helper.dart';

var userData;
List postData = [];
List userPostData = [];
var postDetailData;
var clickedPostId;
bool isLoggedIn = false;

class DatabaseServices {
  static var db = DatabaseHelper();
  User? user;

  Future register(String username, String password, String mail,
      String firstName, String lastName, String phoneNum) async {
    await db.Connection().then((conn) async {
      String query =
          """INSERT INTO users (username, pass, mail) VALUES ('$username','$password','$mail');""";
      String queryTwo =
          """INSERT INTO userinfos VALUES ((SELECT user_id FROM users WHERE username = '$username' AND pass = '$password'), '$firstName', '$lastName', '$phoneNum')""";
      await conn.query(query);
      await conn.query(queryTwo).then((result) {
        print("Inserted!");
      });
    });
  }

  Future getPosts(String statusDetail, String minPrice, String maxPrice,
      int postType) async {
    await db.Connection().then((conn) async {
      String query = """SELECT * FROM posts 
      INNER JOIN postStatuses ON postStatuses.status_id = posts.postStatus
      INNER JOIN photos ON posts.post_id = photos.post_id
      GROUP BY posts.post_id""";

      if (statusDetail != "" ||
          minPrice != "" ||
          maxPrice != "" ||
          postType != 0) {
        query = query + " HAVING";
      }

      if (postType == 1)
        query = query + " postType = 1";
      else if (postType == 2)
        query = query + " postType = 2";
      else if (postType == 3) query = query + " postType = 3";

      if (statusDetail != "") {
        query = query + " statusDetail = '$statusDetail'";
        if (minPrice != "") {
          query = query + " AND price >= '$minPrice'";
        }
        if (maxPrice != "") {
          query = query + " AND price <= '$maxPrice'";
        }
      } else {
        if (minPrice != "") {
          query = query + " price >= '$minPrice'";
          if (maxPrice != "") {
            query = query + " AND price <= '$maxPrice'";
          }
        } else if (maxPrice != "") {
          query = query + " price <= '$maxPrice'";
        }
      }

      await conn.query(query).then((results) async {
        Post? post;
        for (var i = 0; i < results.length; i++) {
          var result = results.toList()[i];
          post = Post(result[0], result[1], result[2], result[3], result[4],
              result[5], result[6], result[9], result[11]);
          var postMap = post.createMap();
          postData.add(postMap);
        }
      });
      await conn.close();
    });
  }

  Future login(String username, String password) async {
    await db.Connection().then((conn) async {
      String query = """SELECT * FROM users 
          INNER JOIN userinfos ON userinfos.user_id = users.user_id
          WHERE username = '$username' AND pass = '$password'""";
      await conn.query(query).then((result) async {
        if (result.toString() != '()') {
          var resultList = result.toList()[0];
          user = User(
              resultList["user_id"],
              resultList["username"],
              resultList["pass"],
              resultList["mail"],
              resultList["firstName"],
              resultList["lastName"],
              resultList["phoneNumber"]);
        } else {
          print("Böyle bir kullanıcı yok!");
          return null;
        }
      });
      await conn.close();
    });
    return user;
  }

  Future getPostDetails(int postId, int postType) async {
    String type = "house";
    if (postType.toString() == "1")
      type = "house";
    else if (postType.toString() == "2")
      type = "shop";
    else if (postType.toString() == "3") type = "land";

    await db.Connection().then((conn) async {
      String query = """SELECT * FROM $type 
      INNER JOIN posts ON posts.post_id = $type.post_id
      INNER JOIN users ON posts.owner_id = users.user_id
      INNER JOIN userinfos ON users.user_id = userinfos.user_id
      INNER JOIN additionals ON posts.post_id = additionals.post_id
      WHERE $type.post_id = '$postId'""";
      await conn.query(query).then((result) async {
        if (type == 'house') {
          House? house;
          var resultList = result.toList()[0];
          house = House(
              resultList["post_id"],
              resultList["owner_id"],
              resultList["bathrooms"],
              resultList["bedrooms"],
              resultList["kitchens"],
              resultList["description"],
              resultList["firstName"],
              resultList["lastName"],
              resultList["phoneNumber"],
              resultList["water"],
              resultList["electric"],
              resultList["gas"],
              resultList["network"]);
          var houseMap = house.createMap();
          postDetailData = houseMap;
        } else if (type == 'shop') {
          Shop? shop;
          var resultList = result.toList()[0];
          shop = Shop(
              resultList["post_id"],
              resultList["owner_id"],
              resultList["sectionNumber"],
              resultList["description"],
              resultList["firstName"],
              resultList["lastName"],
              resultList["phoneNumber"],
              resultList["water"],
              resultList["electric"],
              resultList["gas"],
              resultList["network"]);
          var shopMap = shop.createMap();
          postDetailData = shopMap;
        } else if (type == 'land') {
          Land? land;
          var resultList = result.toList()[0];
          land = Land(
              resultList["post_id"],
              resultList["owner_id"],
              resultList["zoning"],
              resultList["titleDeed_status"],
              resultList["description"],
              resultList["firstName"],
              resultList["lastName"],
              resultList["phoneNumber"],
              resultList["water"],
              resultList["electric"],
              resultList["gas"],
              resultList["network"]);
          var landMap = land.createMap();
          postDetailData = landMap;
        }
      });
      await conn.close();
    });
  }

  Future deletePost(int postId, int postType) async {
    String type = "";
    if (postType == 1)
      type = "house";
    else if (postType == 2)
      type = "shop";
    else if (postType == 3) type = "land";

    await db.Connection().then((conn) async {
      await conn.query("DELETE FROM additionals WHERE post_id = $postId");
      await conn.query("DELETE FROM $type WHERE post_id = $postId");
      await conn.query("DELETE FROM photos WHERE post_id = $postId");
      await conn.query("DELETE FROM posts WHERE post_id = $postId");
      conn.close();
    });
  }

  Future getUserPosts(int userId) async {
    await db.Connection().then((conn) async {
      String query = """SELECT * FROM posts 
      INNER JOIN postStatuses ON postStatuses.status_id = posts.postStatus
      INNER JOIN photos ON posts.post_id = photos.post_id
      WHERE owner_id = '$userId'""";
      await conn.query(query).then((results) {
        Post? post;
        for (var i = 0; i < results.length; i++) {
          var result = results.toList()[i];
          post = Post(result[0], result[1], result[2], result[3], result[4],
              result[5], result[6], result[9], result[11]);
          var postMap = post.createMap();
          userPostData.add(postMap);
        }
      });
      conn.close();
    });
  }

  Future updateUser(Map<String, String> updatingData, int userId) async {
    await db.Connection().then((conn) async {
      for (var key in updatingData.keys) {
        String query =
            """UPDATE users, userinfos SET $key = '${updatingData[key]}' WHERE users.user_id = $userId""";
        await conn.query(query).then((result) => print("Updated!"));
        userData[key] = updatingData[key];
      }
      conn.close();
    });
  }

  Future addPost(Map<String, dynamic> addingData) async {
    await db.Connection().then((conn) async {
      if (addingData["postType"] == 1) {
        // House obj
        String sql =
            """INSERT INTO posts (owner_id, postHead, city, postType, pitch, price, postStatus) VALUES ('${userData["userId"]}','${addingData["postHead"]}', '${addingData["city"]}', '${addingData["postType"]}', '${addingData["pitch"]}', '${addingData["price"]}', '${addingData["postStatus"]}');""";

        var res = await conn.query(sql);
        await conn.query(
            "INSERT INTO house VALUES (${res.insertId}, ${addingData["bathrooms"]}, ${addingData["bedrooms"]}, ${addingData["kitchens"]}, '${addingData["desc"]}')");
        await conn.query(
            "INSERT INTO additionals VALUES (${res.insertId}, ${addingData["haveWater"]}, ${addingData["haveElectric"]}, ${addingData["haveGas"]}, ${addingData["haveNet"]})");
        await conn.query(
            "INSERT INTO photos VALUES (${res.insertId}, '${addingData["photo"]}')");
      } else if (addingData["postType"] == 2) {
        // Shop obj
        String sql =
            """INSERT INTO posts (owner_id, postHead, city, postType, pitch, price, postStatus) VALUES ('${userData["userId"]}','${addingData["postHead"]}', '${addingData["city"]}', '${addingData["postType"]}', '${addingData["pitch"]}', '${addingData["price"]}', '${addingData["postStatus"]}');""";

        var res = await conn.query(sql);
        await conn.query(
            "INSERT INTO shop VALUES (${res.insertId}, ${addingData["sectionNumber"]}, '${addingData["desc"]}')");
        await conn.query(
            "INSERT INTO additionals VALUES (${res.insertId}, ${addingData["haveWater"]}, ${addingData["haveElectric"]}, ${addingData["haveGas"]}, ${addingData["haveNet"]})");
        await conn.query(
            "INSERT INTO photos VALUES (${res.insertId}, '${addingData["photo"]}')");
      } else if (addingData["postType"] == 3) {
        // Land obj
        String sql =
            "INSERT INTO posts (owner_id, postHead, city, postType, pitch, price, postStatus) VALUES (${userData["userId"]},'${addingData["postHead"]}', '${addingData["city"]}', ${addingData["postType"]}, ${addingData["pitch"]}, ${addingData["price"]}, '${addingData["postStatus"]}');";

        var res = await conn.query(sql);
        await conn.query(
            "INSERT INTO land VALUES (${res.insertId}, ${addingData["zoning"]}, ${addingData["titleDeed"]}, '${addingData["desc"]}')");
        await conn.query(
            "INSERT INTO additionals VALUES (${res.insertId}, ${addingData["haveWater"]}, ${addingData["haveElectric"]}, ${addingData["haveGas"]}, ${addingData["haveNet"]})");
        await conn.query(
            "INSERT INTO photos VALUES (${res.insertId}, '${addingData["photo"]}')");
      }
      conn.close();
    });
  }
}
