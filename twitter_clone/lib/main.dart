
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/database_provider.dart';
import 'package:twitter_clone/ui/home_page.dart';
import 'package:twitter_clone/ui/login_page.dart';
import 'package:twitter_clone/user_info_provider.dart';

import 'main_style.dart';

void main() {

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<DatabaseProvider>(create: (_) => DatabaseProvider()),
          ChangeNotifierProvider<UserInfoProvider>(create: (_) => UserInfoProvider()),
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState(){
    super.initState();
    context.read<DatabaseProvider>().isExistUserEmail('qwer');
    context.read<DatabaseProvider>().isRightPWD('qwer','qwer');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      home: Container(
          color: mainTheme.canvasColor,
          child: const LogInPage()),
    );
  }
}
