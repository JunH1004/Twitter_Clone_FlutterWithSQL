import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';

Set<Set<String>> dummyTweets = {
  //tweet id, user id, content, created at
  {'1', '이준혁', '나 이준혁 아니다', '2004.02.18'},
  {'2', '이준민', '나 이준혁 맞다', '2004.02.18'},
  {'3', '엄준식', '엄마가 준비한 식사는 최고야', '2004.02.18'},
  {'1', '이준혁', '나 이준혁 아니다', '2004.02.18'},
  {'2', '이준민', '나 이준혁 맞다', '2004.02.18'},
  {'3', '엄준식', '엄마가 준비한 식사는 최고야', '2004.02.18'},
  {'1', '이준혁', '나 이준혁 아니다', '2004.02.18'},
  {'2', '이준민', '나 이준혁 맞다', '2004.02.18'},
  {'3', '엄준식', '엄마가 준비한 식사는 최고야', '2004.02.18'},
  {'1', '이준혁', '나 이준혁 아니다', '2004.02.18'},
  {'2', '이준민', '나 이준혁 맞다', '2004.02.18'},
  {'3', '엄준식', '엄마가 준비한 식사는 최고야', '2004.02.18'},
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Board(
                  0,
                  dummyTweets.elementAt(index).elementAt(1), // 인덱스 1이 사용자 이름이라고 가정합니다
                  dummyTweets.elementAt(index).elementAt(3),
                  dummyTweets.elementAt(index).elementAt(2), // 인덱스 2가 트윗 내용이라고 가정합니다
                  1,
                  3,
                );
              },
              childCount: dummyTweets.length,
            ),
          ),
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
