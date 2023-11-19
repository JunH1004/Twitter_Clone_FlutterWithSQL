import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';
import 'package:twitter_clone/ui/homepage_tabs/home_tab.dart';
import 'package:twitter_clone/ui/homepage_tabs/search_tab.dart';

Set<Set<String>> dummyTweets = {
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
class ProfilePage extends StatefulWidget {
  int userId;
  String userName;
  ProfilePage(this.userId, this.userName);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //init 유저 id로 그 유저가 무슨 글 썼는데 가져오기
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
              title: Text(widget.userName, style: MyTextStyles.h2_b,),
            ),
              leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left,color: MyColors.black,),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  }
              )
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
    );
  }
}
