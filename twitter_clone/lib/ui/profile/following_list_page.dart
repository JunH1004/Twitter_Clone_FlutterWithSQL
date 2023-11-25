import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/ui/profile/profile_card.dart';

import '../../database_provider.dart';
import '../../main_style.dart';

class FollowingListPage extends StatefulWidget {
  FollowingListPage(this.userID);
  int userID;
  @override
  State<FollowingListPage> createState() => _FollowingListPageState();
}

class _FollowingListPageState extends State<FollowingListPage> {
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
              title: Text('Following', style: MyTextStyles.h2_b),
            ),
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left, color: MyColors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          FollowingList(widget.userID),
        ],
      ),
    );
  }
}

class FollowingList extends StatefulWidget {
  FollowingList(this.userID);
  int userID;
  @override
  State<FollowingList> createState() => _State();
}

class _State extends State<FollowingList> {
  Future<List<Map<String, dynamic>>>? followingList;

  @override
  void initState() {
    super.initState();
    followingList = DatabaseProvider().getFollowings(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: followingList,
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
              child: Text('No Followings'),
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
