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
      body: CustomScrollView(
        slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              backgroundColor: mainTheme.canvasColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Doge Twitter', style: MyTextStyles.h2_b,),
                background: Image.asset('assets/DogeCoin.png',width: 400,height: 400,),
              ),
            ),
            Board('이준혁','2099.13.32.','나 이준혁 아니다', 1,3 ),
            Board('LeeJunMin','2099.13.34.','가나다라마바사아자차카타파하ABCDEFGHIJK', 99,3 ),
            Board('LeeJunMin','2099.13.34.','가나다라마바사아자차카타파하ABCDEFGHIJK가나다라마바사아자차카타파하ABCDEFGHIJK가나다라마바사아자차카타파하ABCDEFGHIJK', 99,3 ),
          Board('이준혁','2099.13.32.','나 이준혁 아니다', 1,3 ),
          Board('이준혁','2099.13.32.','나 이준혁 아니다', 1,3 ),
          Board('이준혁','2099.13.32.','나 이준혁 아니다', 1,3 ),
          ],
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
