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

  //user <- follower_id, 다른사람이 유저를 팔로우
  //user -> following_id, 유저가 다른 사람을 팔로우
  Future<bool> amIFollowHim(int myID, int hisID) async{
    String q =
        "SELECT * FROM following "
        "WHERE following_id = $hisID AND user_id = $myID;";
    //INSERT INTO User (Email, user_name, password, Follower_Cnt, Following_Cnt)
    // VALUES ('user@example.com', 'UserName', 'user_password', 0, 0);
    IResultSet result = await query(q);
    if (result.numOfRows > 0){
      return true;
    }
    return false;
  }

  Future<void> follow(int myID, int hisID) async{
    String q =
        "INSERT INTO following (user_id, following_id, created_at) "
        "VALUES ($myID, $hisID, NOW());";
    await query(q);
    //내가 그사람을 팔로우한다 쿼리

    q =
        "INSERT INTO follower (user_id, follower_id, created_at) "
        "VALUES ($hisID, $myID, NOW());";
    await query(q);
    //그사람이 나한테 팔로우 된다 쿼리

    q =
    "UPDATE user "
    "SET follower_cnt = follower_cnt + 1 "
    "WHERE user_id = $hisID; " ;
    await query(q);

    q =
    "UPDATE user "
    "SET following_cnt = following_cnt + 1 "
    "WHERE user_id = $myID; " ;
    await query(q);
  }

  Future<void> unfollow(int myID, int hisID) async {
    // Unfollow 관계 삭제
    String q1 =
        "DELETE FROM following "
        "WHERE user_id = $myID AND following_id = $hisID;";
    await query(q1);

    // Unfollow 되는 사용자의 팔로워 관계 삭제
    String q2 =
        "DELETE FROM follower "
        "WHERE user_id = $hisID AND follower_id = $myID;";
    await query(q2);

    // Unfollow 되는 사용자의 팔로워 수 감소
    String q3 =
        "UPDATE user "
        "SET follower_cnt = follower_cnt - 1 "
        "WHERE user_id = $hisID;";
    await query(q3);

    // 내 팔로잉 수 감소
    String q4 =
        "UPDATE user "
        "SET following_cnt = following_cnt - 1 "
        "WHERE user_id = $myID;";
    await query(q4);
  }

  Future<Map<String, dynamic>> getUserInfo(int user_id) async {

    String q =
        "SELECT user_id, email, user_name, follower_cnt, following_cnt "
        "FROM user "
        "WHERE user_id = $user_id;";

    IResultSet result =  await query(q);
    Map<String, dynamic> user_info = {};
    for (final row in result.rows) {
      user_info = row.assoc();
      print(row.assoc());
    }
    return user_info;
  }

  Future<List<Map<String, dynamic>>> getFollowings(int user_id) async {
    //유저가 팔로우 하는 사람!
    String q =
        "SELECT User.user_id, User.user_name "
        "FROM Following "
        "JOIN User ON Following.Following_id = User.user_id "
        "WHERE Following.user_id = $user_id;";

    IResultSet result =  await query(q);
    List<Map<String, dynamic>> followings = [];
    for (final row in result.rows) {
      followings.add(row.assoc());
      print(row.assoc());
    }
    return followings;
  }

  Future<List<Map<String, dynamic>>> getFollowers(int user_id) async {
    //유저를 팔로우하는 사람!
    String q =
        "SELECT User.user_id, User.user_name "
        "FROM Follower "
        "JOIN User ON Follower.follower_id = User.user_id "
        "WHERE Follower.user_id = $user_id;";

    IResultSet result =  await query(q);
    List<Map<String, dynamic>> followings = [];
    for (final row in result.rows) {
      followings.add(row.assoc());
    }
    return followings;
  }
}
