import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  Future<MySqlConnection> Connection() async {
    var settings = new ConnectionSettings(
        host: '', // hostname here
        port: 3306, // port
        user: '', // username here
        password: '', // password here
        db: ''); // db name (schema) here
    final connection = await MySqlConnection.connect(settings);
    return connection;
  }
}
