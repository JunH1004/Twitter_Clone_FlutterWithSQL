import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:twitter_clone/ui/home_page.dart';
import 'package:twitter_clone/ui/login_page.dart';

import 'main_style.dart';

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

  // 연결 대기
  await conn.connect();

  print("Connected");

  var result = await conn.execute(
    "SELECT * FROM board",
  );

  for (final row in result.rows) {
    // print(row.colAt(0));
    // print(row.colByName("title"));

    // print all rows as Map<String, String>
    print(row.assoc());
  }
  // 종료 대기
  await conn.close();
}
void main() {
  dbConnector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      home: Container(
          color: mainTheme.canvasColor,
          child: const HomePage()),
    );
  }
}
