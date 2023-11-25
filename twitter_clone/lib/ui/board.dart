import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/database_provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board_detail.dart';
import 'package:twitter_clone/ui/profile/profile_page.dart';
import 'package:twitter_clone/user_info_provider.dart';

class Board extends StatefulWidget {
  Board(this.tweetID,this.userID, this.userName, this.date, this.content);
  int tweetID;
  int userID;
  String userName;
  String date;
  String content;
  int commentCnt = 0;
  int likeCnt = 0;
  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  bool liked = false;
  int myID = 0;
  @override
  void initState(){
    super.initState();
    myID = context.read<UserInfoProvider>().getUserId();
    _fetchLikeStatus();
    _fetchCount();
    //like 개수 쿼리
    //댓글 개수 쿼리
    //liked 내가 이 게시물에 좋아요를 눌렀는가? 쿼리
  }
  Future<void> _fetchLikeStatus() async {
    // Perform a query to check if the user has liked this tweet
    bool userLiked = await DatabaseProvider().amILiked(myID, widget.tweetID);

    setState(() {
      liked = userLiked;
    });
  }
  Future<void> _fetchCount() async {
    // Perform a query to check if the user has liked this tweet
    Map<String,dynamic> likeCommentCount = await DatabaseProvider().getLikeAndCommentCnt(widget.tweetID);
    int likeCount = int.parse(likeCommentCount['like_count']);
    int commentCount = int.parse(likeCommentCount['comment_count']);
    setState(() {
      widget.likeCnt = likeCount;
      widget.commentCnt = commentCount;
    });
  }

  void _toggleLike() async {
    if (liked) {
      // Unlike the tweet
      await DatabaseProvider().unlikeTweet(myID, widget.tweetID);
      setState(() {
        liked = false;
        widget.likeCnt -= 1;
      });
    } else {
      // Like the tweet
      await DatabaseProvider().likeTweet(myID, widget.tweetID);
      setState(() {
        liked = true;
        widget.likeCnt += 1;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/DogeCoin.png',width: 64, height: 64,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProfilePage(widget.userID, widget.userName)));
                        }, child: Text(widget.userName,style: MyTextStyles.h2_b,)),
                        Text('@${widget.date.substring(0, 10)}', style: MyTextStyles.h3_o  , overflow: TextOverflow.fade,)
                      ],
                    ),
                    Text(
                      widget.content,style: MyTextStyles.h2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      maxLines: 3,),

                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              liked?
              IconButton(
                  onPressed: (){
                    _toggleLike();
                  },
                  icon: Icon(Icons.favorite,color: MyColors.red,))
              :
              IconButton(
                  onPressed: (){
                    _toggleLike();
                  },
                  icon: Icon(Icons.favorite_border)
              )
              ,
              Text(widget.likeCnt.toString()),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BoardDetailPage(widget.tweetID, widget.userID, widget.userName, widget.date, widget.content)
                ));
              }, icon: Icon(Icons.comment)),
              Text(widget.commentCnt.toString(),
              ),
            ],
          ),
          Divider(thickness: 2,),
        ],
      ),
    );
  }
}