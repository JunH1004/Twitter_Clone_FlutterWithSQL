import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';
import 'package:twitter_clone/user_info_provider.dart';

import '../../database_provider.dart';

class HomepageTab extends StatefulWidget {
  const HomepageTab({Key? key}) : super(key: key);

  @override
  State<HomepageTab> createState() => _HomepageTabState();
}

class _HomepageTabState extends State<HomepageTab> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: false,
          expandedHeight: 200.0,
          backgroundColor: mainTheme.primaryColor,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Doge Twitter', style: MyTextStyles.h2_wb,),
            background: Image.asset('assets/musk.jpg',width: 400,height: 400,fit: BoxFit.fitWidth,),
          ),
        ),
        RecommandTweets(),
      ],
    );
  }
}

class RecommandTweets extends StatefulWidget {
  const RecommandTweets({Key? key}) : super(key: key);

  @override
  State<RecommandTweets> createState() => _RecommandTweetsState();
}

class _RecommandTweetsState extends State<RecommandTweets> {
  Future<List<Map<String, dynamic>>>? tweetsFuture;

  @override
  void initState() {
    super.initState();
    int user_id = context.read<UserInfoProvider>().getUserId();
    tweetsFuture = DatabaseProvider().getFollowingUserTweets(user_id,10);
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
              child: Text('No tweets'),
            ),
          );
        } else {
          List<Map<String, dynamic>> tweets = snapshot.data!;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Board(
                  int.parse(tweets[index]['tweet_id']),
                  int.parse(tweets[index]['user_id']),
                  tweets[index]['user_name'].toString(),
                  tweets[index]['created_at'].toString(),
                  tweets[index]['content'].toString(),
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
