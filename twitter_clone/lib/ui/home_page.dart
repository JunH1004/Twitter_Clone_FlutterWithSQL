import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';
import 'package:twitter_clone/ui/homepage_tabs/home_tab.dart';
import 'package:twitter_clone/ui/homepage_tabs/search_tab.dart';
import 'package:twitter_clone/ui/post_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _mainIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _mainIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        body: [
          HomepageTab(),
          SearchTab()
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
          ],
          selectedItemColor: mainTheme.primaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
