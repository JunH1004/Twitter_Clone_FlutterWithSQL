import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main_style.dart';
import '../profile/profile_page.dart';

class Comment extends StatefulWidget {
  Comment(this.commentID,this.userID, this.userName, this.date, this.content);
  int commentID;
  int userID;
  String userName;
  String date;
  String content;
  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
