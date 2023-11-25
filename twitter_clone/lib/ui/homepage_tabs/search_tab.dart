import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/database_provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';
import 'package:twitter_clone/ui/profile/profile_page.dart';
List<Map<String, dynamic>> tweets = [];
TextEditingController searchController = TextEditingController();
class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  int isSearch = 0;
  @override
  void initState(){
    super.initState();
  }
  void _refresh(){
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0,
          pinned: true,
          backgroundColor: mainTheme.canvasColor,
            title: Container(
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(32),
                            ),
                          ),
                          hintText: '검색 키워드를 입력해주세요',
                          focusColor: mainTheme.primaryColor,
                        ),
                      onTap: () {
                          setState(() {
                            isSearch = 1;
                          });
                      },
                      onChanged: (value){
                        setState(() {
                          
                        });
                      },
                      cursorColor: Colors.grey,
                    ),
                  ),

                  Visibility(
                      visible: isSearch == 1,
                      child: TextButton(onPressed: (){
                        setState(() {
                          isSearch = 0;
                        });
                      }, child: Text("취소",style: MyTextStyles.h3,))
                  )
                ],
              ),
            )

        ),
        [
          RecommandTweets(),
          SearchList(),
        ][isSearch]
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseProvider().getLatestTweets(10),
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


class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseProvider().search(searchController.text),
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
              child: Text('No result'),
            ),
          );
        } else {
          List<Map<String, dynamic>> searchList = snapshot.data!;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  child: Row(
                    children: [
                      Image.asset('assets/DogeCoin.png',width: 64, height: 64,),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProfilePage(int.parse(searchList[index]['user_id']), searchList[index]['user_name'])
                            )
                            );
                          },
                          child: Text(searchList[index]['user_name'], style: MyTextStyles.h2_b,)
                      )

                    ],
                  ),
                );
              },
              childCount: searchList.length,
            ),
          );
        }
      },
    );
  }
}

