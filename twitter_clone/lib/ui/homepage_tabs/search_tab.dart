import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';
Set<Set<String>> dummyProfiles = {
  //user id, user name 여기는 view 사용하면 좋을듯?
  {'1', '이준혁'},
  {'2', '이준민'},
  {'3', '엄준식'},
};
Set<Set<String>> dummyTweets = {
  //내가 팔로우 안 하는 사람들 or 그냥 전체에서 아무거나
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
class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  int isSearch = 0;

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
    return SliverList(
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
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Container(
            child: Row(
              children: [
                Image.asset('assets/DogeCoin.png',width: 64, height: 64,),
                Text(dummyProfiles.elementAt(index).elementAt(1), style: MyTextStyles.h2_b,)
              ],
            ),
          );
        },
        childCount: dummyProfiles.length,
      ),
    );
  }
}
