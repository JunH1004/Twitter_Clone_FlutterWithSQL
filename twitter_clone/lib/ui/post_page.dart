import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainTheme.canvasColor,
          leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left,color: MyColors.black,),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName("/"));
              }
          ),
        actions: [
          Container(
            width: 100,
            margin: EdgeInsets.all(8),
            child: FilledButton(
                style: MyButtonStyles.b1,
                onPressed:(){
                  //INSERT NEW POST

                  Navigator.popUntil(context, ModalRoute.withName("/"));
                },
                child: Center(child: Text("Post",style: MyTextStyles.h3_w,))
            ),
          )
        ],
      ),
      body: TextField(
          controller: postController,

      ),
    );
  }
}
