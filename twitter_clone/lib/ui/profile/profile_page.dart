import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/database_provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';
import 'package:twitter_clone/ui/components/follow_btn.dart';
import 'package:twitter_clone/ui/profile/following_list_page.dart';
import 'package:twitter_clone/user_info_provider.dart';

import 'follower_list_page.dart';

class ProfilePage extends StatefulWidget {
  int userId;
  String userName;

  ProfilePage(this.userId, this.userName);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isMe = false;
  int followingCount = 0;
  int followerCount = 0;

  @override
  void initState() {
    super.initState();
    if (context.read<UserInfoProvider>().getUserId() == widget.userId) {
      isMe = true;
      print('isME');
    }
  }
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      print('ref');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              backgroundColor: mainTheme.canvasColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.userName, style: MyTextStyles.h2_b),
              ),
              leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left, color: MyColors.black),
                onPressed: () {
                  Navigator.pop(context, (route) => route.isFirst);
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: UserFollowInfo(widget.userId, onUpdate: _updateCounts),
                    ),
                    Expanded(
                      child:
                          Container(
                            margin: EdgeInsets.fromLTRB(64, 0, 0, 0),
                            child:
                              isMe == false?
                              FollowBtn(widget.userId, onUpdate: _updateCounts)
                              :
                              ElevatedButton(
                                style: MyButtonStyles.b1_off,
                                onPressed: () {},
                                child: Text("Edit profile", style: MyTextStyles.h3_w),
                              )
                          )
                    ),
                  ],
                ),
              ),
            ),
            UserTweets(widget.userId),
          ],
        ),
      ),
    );
  }

  // 팔로잉 및 팔로워 수 업데이트
  void _updateCounts() {
    setState(() {
    });
  }
}

class UserFollowInfo extends StatefulWidget {
  UserFollowInfo(this.userID, {required this.onUpdate});

  final int userID;
  final Function() onUpdate;

  @override
  State<UserFollowInfo> createState() => _UserFollowInfoState();
}

class _UserFollowInfoState extends State<UserFollowInfo> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: DatabaseProvider().getUserInfo(widget.userID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('0 Following'),
              Text('0 Follower'),
            ],
          );
        } else if (snapshot.hasError) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('0 Following'),
              Text('0 Follower'),
            ],
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('0 Following'),
              Text('0 Follower'),
            ],
          );
        } else {
          Map<String, dynamic> userInfo = snapshot.data!;
          int following = int.parse(userInfo['following_cnt']);
          int followers = int.parse(userInfo['follower_cnt']); // 업데이트 콜백 호출

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) =>
                            FollowingListPage(int.parse(userInfo['user_id']))
                    ));
                  },
                  child: Text('$following Following'),
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) =>
                          FollowerListPage(int.parse(userInfo['user_id']))
                  ));
                },
                child:Text('$followers Follower'),
              ),
            ],
          );
        }
      },
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseProvider().getUserTweets(widget.userID),
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
