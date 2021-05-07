class House {
  int _postId;
  int _ownerId;
  int _bathrooms;
  int _bedrooms;
  int _kitchens;
  String _desc;
  String _ownerName;
  String _ownerSurname;
  String _phone;
  int _water;
  int _electric;
  int _gas;
  int _network;

  House(
      this._postId,
      this._ownerId,
      this._bathrooms,
      this._bedrooms,
      this._kitchens,
      this._desc,
      this._ownerName,
      this._ownerSurname,
      this._phone,
      this._water,
      this._electric,
      this._gas,
      this._network);

  Map<String, dynamic> createMap() {
    var map = new Map<String, dynamic>();
    map["postId"] = _postId;
    map["ownerId"] = _ownerId;
    map["bathrooms"] = _bathrooms;
    map["bedrooms"] = _bedrooms;
    map["kitchens"] = _kitchens;
    map["desc"] = _desc;
    map["ownerName"] = _ownerName;
    map["ownerSurname"] = _ownerSurname;
    map["phoneNum"] = _phone;
    map["haveWater"] = _water;
    map["haveElectric"] = _electric;
    map["haveGas"] = _gas;
    map["haveNet"] = _network;
    return map;
  }
}
