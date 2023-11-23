import 'package:flutter/cupertino.dart';
import 'package:mysql_client/mysql_client.dart';

class DatabaseProvider extends ChangeNotifier {


  Future<void> dbConnector() async {
    print("Connecting to mysql server...");

    // MySQL 접속 설정
    final conn = await MySQLConnection.createConnection(
      host: 'localhost',
      port: 3306,
      userName: 'root',
      password: 'junlee1004@',
      databaseName: 'dogetest', // optional
    );
    await conn.connect();
    print("connected");
  }


  Future<IResultSet> query(String q) async {
    print("Connecting to mysql server...");

    // MySQL 접속 설정
    final conn = await MySQLConnection.createConnection(
      host: 'localhost',
      port: 3306,
      userName: 'root',
      password: 'junlee1004@',
      databaseName: 'dogetest', // optional
    );
    await conn.connect();
    print("connected");
    var result = await conn.execute(
      q,
    );
    await conn.close();
    return result;
  }

  Future<bool> isExistUserEmail(String user_email) async {
    IResultSet result = await query("SELECT * FROM user WHERE email = '$user_email'");
    if (result.numOfRows > 0){
      return true;
    }
    return false;
  }
}
