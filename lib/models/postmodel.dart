class Post {
  int _postId;
  int _ownerId;
  String _postHead;
  String _city;
  int _postType;
  int _pitch;
  int _price;
  String _postStatus;
  String _photo;

  Post(this._postId, this._ownerId, this._postHead, this._city, this._postType,
      this._pitch, this._price, this._postStatus, this._photo);
  
  Map<String, dynamic> createMap(){
    var map = new Map<String, dynamic>();
    map["postId"] = _postId;
    map["ownerId"] = _ownerId;
    map["postHead"] = _postHead;
    map["city"] = _city;
    map["postType"] = _postType;
    map["pitch"] = _pitch;
    map["price"] = _price;
    map["postStatus"] = _postStatus;
    map["photo"] = _photo;
    return map;
  }
}