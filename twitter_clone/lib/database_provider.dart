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
    print('query : ' + q);
    // MySQL 접속 설정
    final conn = await MySQLConnection.createConnection(
      host: 'localhost',
      port: 3306,
      userName: 'root',
      password: 'junlee1004@',
      databaseName: 'dogetest', // optional
    );
    await conn.connect();
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
  Future<bool> isRightPWD(String user_email, String pwd) async {
    //이메일이 존재한다는 가정하에 실행
    IResultSet result = await query("SELECT password FROM user WHERE email = '$user_email'");
    if (result.rows.elementAt(0).colAt(0) == pwd){
      return true;
    }
    return false;
  }

  Future<void> signUp(String email, String name, String pwd) async{
    String q =
        "INSERT INTO User (Email, user_name, password,created_at, Follower_Cnt, Following_Cnt)"
        "VALUES ('$email', '$name', '$pwd',NOW(), 0, 0)";
    //INSERT INTO User (Email, user_name, password, Follower_Cnt, Following_Cnt)
    // VALUES ('user@example.com', 'UserName', 'user_password', 0, 0);
    query(q);
  }
}
