import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';

class Board extends StatefulWidget {
  Board(this.userName, this.date, this.content, this.like, this.commentCnt);
  String userName;
  String date;
  String content;
  int commentCnt;
  int like;
  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.account_circle_outlined,size: 64,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(widget.userName,style: MyTextStyles.h2_b,),
                        Text('@${widget.date}', style: MyTextStyles.h2_o,)
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
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
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
