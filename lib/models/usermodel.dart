class User {
  int _userId;
  String _username;
  String _password;
  String _mail;
  String _firstName;
  String _lastName;
  String _phoneNumber;

  User(this._userId, this._username, this._password, this._mail,
      this._firstName, this._lastName, this._phoneNumber);

  Map<String, dynamic> createMap(){
    var map = new Map<String, dynamic>();
    map["userId"] = _userId;
    map["username"] = _username;
    map["pass"] = _password;
    map["mail"] = _mail;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["phoneNumber"] = _phoneNumber;
    return map;
  }
}