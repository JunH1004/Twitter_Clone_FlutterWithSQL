import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/database_provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';
import 'package:twitter_clone/ui/homepage_tabs/home_tab.dart';
import 'package:twitter_clone/ui/homepage_tabs/search_tab.dart';
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
                    Navigator.pop(context, (route) => route.isFirst);
                  }
              )
          ),
          UserTweets(widget.userId)
        ],
      ),
    );
  }
}

class UserTweets extends StatefulWidget {
  UserTweets(this.userID);
  int userID;
  @override
  State<UserTweets> createState() => _UserTweetsState();
}

class _UserTweetsState extends State<UserTweets> {
  Future<List<Map<String, dynamic>>>? tweetsFuture;

  @override
  void initState() {
    super.initState();
    tweetsFuture = DatabaseProvider().getUserTweets(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: tweetsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text('No tweets available.'),
            ),
          );
        } else {
          List<Map<String, dynamic>> tweets = snapshot.data!;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Board(
                  0,
                  int.parse(tweets[index]['user_id']),
                  tweets[index]['user_name'].toString(),
                  tweets[index]['created_at'].toString(),
                  tweets[index]['content'].toString(),
                  1,
                  3,
                );
              },
              childCount: tweets.length,
            ),
          );
        }
      },
    );
  }
}