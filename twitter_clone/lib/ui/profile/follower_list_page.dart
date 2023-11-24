import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/ui/profile/profile_card.dart';

import '../../database_provider.dart';
import '../../main_style.dart';

class FollowerListPage extends StatefulWidget {
  FollowerListPage(this.userID);
  int userID;
  @override
  State<FollowerListPage> createState() => _FollowerListPageState();
}

class _FollowerListPageState extends State<FollowerListPage> {
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
              title: Text('Follower', style: MyTextStyles.h2_b),
            ),
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left, color: MyColors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          FollowerList(widget.userID),
        ],
      ),
    );
  }
}

class FollowerList extends StatefulWidget {
  FollowerList(this.userID);
  int userID;
  @override
  State<FollowerList> createState() => _State();
}

class _State extends State<FollowerList> {
  Future<List<Map<String, dynamic>>>? followerList;

  @override
  void initState() {
    super.initState();
    followerList = DatabaseProvider().getFollowers(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: followerList,
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
              child: Text('No Followers'),
            ),
          );
        } else {
          List<Map<String, dynamic>> followingList = snapshot.data!;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return ProfileCard(int.parse(followingList[index]['user_id']));
              },
              childCount: followingList.length,
            ),
          );
        }
      },
    );
  }
}
