import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/board.dart';
import 'package:twitter_clone/ui/components/comment.dart';
import 'package:twitter_clone/ui/profile/profile_page.dart';

import '../database_provider.dart';
import '../user_info_provider.dart';
Future<List<Map<String, dynamic>>>? comments;
class BoardDetailPage extends StatefulWidget {
  BoardDetailPage(this.tweetID, this.userID, this.userName, this.date, this.content);
  int tweetID;
  int userID;
  String userName;
  String date;
  String content;
  @override
  State<BoardDetailPage> createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  TextEditingController commentController = TextEditingController();
  bool isPostButtonEnabled = false;
  bool isReplyButtonPressed = false;

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // 초기화 작업
    _refresh();
  }

  // 댓글 리스트를 갱신하는 메서드
  void _refresh() {
    setState(() {
      comments = DatabaseProvider().getComments(widget.tweetID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            backgroundColor: mainTheme.canvasColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Comment', style: MyTextStyles.h2_b),
            ),
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left, color: MyColors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Board(widget.tweetID, widget.userID, widget.userName, widget.date, widget.content),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    maxLines: 1,
                    maxLength: 255,
                    controller: commentController,
                    onChanged: (value) {
                      isReplyButtonPressed = false;
                      setState(() {
                        isPostButtonEnabled = value.trim().isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Comment your reply',
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 100,
                    child: FilledButton(
                      style: MyButtonStyles.b1,
                      onPressed: isPostButtonEnabled
                          ? () async {
                        int user_id = context.read<UserInfoProvider>().getUserId();
                        await context.read<DatabaseProvider>().replyComment(user_id, widget.tweetID,commentController.text);
                        commentController.clear();
                        isReplyButtonPressed = true;
                        setState(() {
                          isPostButtonEnabled = false;
                        });
                      }
                          : null,
                      child: Center(child: Text("Reply", style: MyTextStyles.h3_w)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CommentList(widget.tweetID, isReplyButtonPressed),
        ],
      ),
    );
  }
}

class CommentList extends StatefulWidget {
  CommentList(this.tweetID, this.isReplyButtonPressed);
  int tweetID;
  bool isReplyButtonPressed;
  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {

  @override
  void initState() {
    super.initState();
    comments = DatabaseProvider().getComments(widget.tweetID);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isReplyButtonPressed) {
      // 댓글이 추가되었을 때만 댓글 리스트를 갱신
      widget.isReplyButtonPressed = false;
      comments = DatabaseProvider().getComments(widget.tweetID);
    }

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: comments,
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
              child: Text('No comment'),
            ),
          );
        } else {
          List<Map<String, dynamic>> comments = snapshot.data!;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Comment(
                  int.parse(comments[index]['comment_id']),
                  int.parse(comments[index]['user_id']),
                  comments[index]['user_name'].toString(),
                  comments[index]['created_at'].toString(),
                  comments[index]['content'].toString(),
                );
              },
              childCount: comments.length,
            ),
          );
        }
      },
    );
  }
}
