import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';

class HomepageTab extends StatefulWidget {
  const HomepageTab({Key? key}) : super(key: key);

  @override
  State<HomepageTab> createState() => _HomepageTabState();
}

class _HomepageTabState extends State<HomepageTab> {
  Set<Set<String>> dummyTweets = {
    //내가 팔로우 하는 사람들만
    //tweet id, user id, content, created at
    {'1', 'Name', 'Content', '2004.02.18'},
    {'1', 'Name', 'Content', '2004.02.18'},
    {'1', 'Name', 'Content', '2004.02.18'},
    {'1', 'Name', 'Content', '2004.02.18'},
    {'1', 'Name', 'Content', '2004.02.18'},
    {'1', 'Name', 'Content', '2004.02.18'},
    {'1', 'Name', 'Content', '2004.02.18'},
    {'1', 'Name', 'Content', '2004.02.18'},
    {'1', 'Name', 'Content', '2004.02.18'},
    {'1', 'Name', 'Content', '2004.02.18'},
    {'1', 'Name', 'Content', '2004.02.18'},
    {'1', 'Name', 'Content', '2004.02.18'},
  };
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                0,
                0,
              );
            },
            childCount: dummyTweets.length,
          ),
        ),
      ],
    );
  }
}
