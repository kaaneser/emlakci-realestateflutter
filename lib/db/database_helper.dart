import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  Future<MySqlConnection> Connection() async {
    var settings = new ConnectionSettings(
        host: 'eu-cdbr-west-01.cleardb.com', // hostname
        port: 3306, // port
        user: 'bb70db9070f4b5', // username
        password: '543ddd1d', // password
        db: 'heroku_c595c6e66ec24c9'); // db name (schema)
    final connection = await MySqlConnection.connect(settings);
    return connection;
  }
}
