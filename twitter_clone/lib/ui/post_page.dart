import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/database_provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/home_page.dart';
import 'package:twitter_clone/user_info_provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController postController = TextEditingController();
  bool isPostButtonEnabled = false;
  int maxCharacterLimit = 25;

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainTheme.canvasColor,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: MyColors.black),
          onPressed: () {
            Navigator.pop(context, (route) => route.isFirst);
          },
        ),
        actions: [
          Container(
            width: 100,
            margin: EdgeInsets.all(8),
            child: FilledButton(
              style: MyButtonStyles.b1,
              onPressed: isPostButtonEnabled
                  ? () async {
                int user_id = context.read<UserInfoProvider>().getUserId();
                await context.read<DatabaseProvider>().postTweet(user_id, postController.text);
                Navigator.pop(context, (route) => route.isFirst);
              }
                  : null, // 버튼이 비활성화 상태인 경우 null로 설정
              child: Center(child: Text("Post", style: MyTextStyles.h3_w)),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              maxLines: 5,
              maxLength: maxCharacterLimit,
              controller: postController,
              onChanged: (value) {
                // TextField의 내용이 변경될 때 호출되는 콜백
                setState(() {
                  // 버튼 활성화 여부 업데이트
                  isPostButtonEnabled = value.trim().isNotEmpty;
                });
              },
              decoration: InputDecoration(
                hintText: '무슨 일이 일어나고 있나요?',
                // 여기에서 다른 외관 속성을 사용자 정의할 수 있습니다.
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
