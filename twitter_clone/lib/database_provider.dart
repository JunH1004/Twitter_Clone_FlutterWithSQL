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
  Future<List<IResultSet>> queryToList(String q) async {
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
    return result.toList();
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

  Future<int> getUserId(String user_email) async {
    IResultSet result = await query("SELECT user_id FROM user WHERE email = '$user_email'");
    if (result.numOfRows > 0){
      print('user_id : ${int.parse(result.rows.elementAt(0).colAt(0).toString())}');
      return int.parse(result.rows.elementAt(0).colAt(0).toString());
    }
    return -1;
  }

  Future<void> postTweet(int user_id, String content) async{
    String q =
        """INSERT INTO tweet (user_id, content) VALUES ($user_id, '$content')""";
    query(q);
  }

  Future<List<Map<String, dynamic>>> getLatestTweets(int n) async {
    //List
    //Map< user_id:, content:, user_name:, created_at: >

    String q =
        'SELECT tweet.user_id, user.user_name, tweet.content, tweet.created_at '
        'FROM tweet '
        'JOIN user ON tweet.user_id = user.user_id '
        'ORDER BY tweet.created_at DESC '
        'LIMIT 10';
    IResultSet result =  await query(q);
    List<Map<String, dynamic>> tweets = [];
    for (final row in result.rows) {
      // for every row in result set
      tweets.add(row.assoc());
      print(row.assoc());
    }
    return tweets;
  }

  Future<List<Map<String, dynamic>>> getUserTweets(int user_id) async {
    //List
    //Map< user_id:, content:, user_name:, created_at: >

    String q =
        'SELECT tweet.user_id, user.user_name, tweet.content, tweet.created_at '
        'FROM tweet '
        'JOIN user ON tweet.user_id = user.user_id '
        'WHERE user.user_id = $user_id '
        'ORDER BY tweet.created_at DESC; ';
    IResultSet result =  await query(q);
    List<Map<String, dynamic>> tweets = [];
    for (final row in result.rows) {
      // for every row in result set
      tweets.add(row.assoc());
      print(row.assoc());
    }
    return tweets;
  }
}
