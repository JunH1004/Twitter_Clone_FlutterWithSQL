import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';

Set<Set<String>> dummyContent = {
  {'1', '이준혁', '나 이준혁 아니다',},
  {'2', '이준민', '나 이준혁 맞다',},
  {'3', '엄준식', '엄마가 준비한 식사는 최고야',},
};
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
    return Scaffold(
      appBar: AppBar(
        title: Container(
            width: 150,
            height: 150,
            child: Image.asset('assets/DogeCoin.png')

        ),
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),

      body: Container(
        child: Column(
          children: [
            Board('이준혁','2099.13.32.','나 이준혁 아니다', 1,3 ),
            Board('LeeJunMin','2099.13.34.','가나다라마바사아자차카타파하ABCDEFGHIJK', 99,3 ),
            Board('LeeJunMin','2099.13.34.','가나다라마바사아자차카타파하ABCDEFGHIJK가나다라마바사아자차카타파하ABCDEFGHIJK가나다라마바사아자차카타파하ABCDEFGHIJK', 99,3 ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
