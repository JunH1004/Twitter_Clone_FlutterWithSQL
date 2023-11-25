import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';
import 'package:twitter_clone/ui/homepage_tabs/home_tab.dart';
import 'package:twitter_clone/ui/homepage_tabs/search_tab.dart';
import 'package:twitter_clone/ui/post_page.dart';
import 'package:twitter_clone/ui/profile/profile_page.dart';
import 'package:twitter_clone/user_info_provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _mainIndex = 0;
  int userID = 0;
  String userName = "";
  @override
  void initState(){
    super.initState();
    userID = context.read<UserInfoProvider>().getUserId();
    userName = context.read<UserInfoProvider>().getUserName();
  }
  void _onItemTapped(int index) {
    setState(() {
      _mainIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    print('homepage ${userID} $userName');
    return Container(
      color: mainTheme.canvasColor,
      child: SafeArea(

        child: Scaffold(
          body: [
            HomepageTab(),
            SearchTab(),
            ProfilePage(userID, context.watch<UserInfoProvider>().getUserName())
          ][_mainIndex],
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainTheme.primaryColor,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => PostPage()));
            },
            child: Center(
              child: Icon(Icons.add,size: 32,),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            currentIndex: _mainIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: ""
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
              label: ""
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: ""
              ),
            ],
            selectedItemColor: mainTheme.primaryColor,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
