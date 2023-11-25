import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/profile/profile_page.dart';

class Board extends StatefulWidget {
  Board(this.tweetID,this.userID, this.userName, this.date, this.content, this.like, this.commentCnt);
  int tweetID;
  int userID;
  String userName;
  String date;
  String content;
  int commentCnt;
  int like;
  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  bool liked = false;

  void addLike(){
    setState(() {
      liked = true;
      widget.like += 1;
    });
  }

  void delLike(){
    setState(() {
      liked = false;
      widget.like -= 1;
    });
  }
  @override
  void initState(){
    super.initState();
    //like 개수 쿼리
    //댓글 개수 쿼리
    //liked 내가 이 게시물에 좋아요를 눌렀는가? 쿼리
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
                      children: [
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProfilePage(widget.userID, widget.userName)));
                        }, child: Text(widget.userName,style: MyTextStyles.h2_b,)),
                        Text('@${widget.date}', style: MyTextStyles.h3  ,)
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
                    delLike();
                  },
                  icon: Icon(Icons.favorite,color: MyColors.red,))
              :
              IconButton(
                  onPressed: (){
                    addLike();
                  },
                  icon: Icon(Icons.favorite_border)
              )
              ,
              Text(widget.commentCnt.toString()),
              IconButton(onPressed: (){}, icon: Icon(Icons.comment)),
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