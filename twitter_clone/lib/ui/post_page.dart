import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/home_page.dart';

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
                  ? () {
                // 게시물 내용 유효성 검사
                String postContent = postController.text.trim();
                if (postContent.isNotEmpty) {
                  // TODO: 여기에 게시물 제출 로직을 구현하세요.
                  // 예를 들어, 게시물 내용을 서버로 전송하거나
                  // 새로운 게시물로 앱 상태를 업데이트할 수 있습니다.
                  print("게시 중: $postContent");

                  // PostPage 닫기
                  Navigator.pop(context);
                } else {
                  // 게시물 내용이 비어 있으면 오류 메시지 표시 또는 제출 방지
                  print("오류: 게시물 내용이 비어 있습니다");
                }
              }
                  : null, // 버튼이 비활성화 상태인 경우 null로 설정
              child: Center(child: Text("게시", style: MyTextStyles.h3_w)),
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
