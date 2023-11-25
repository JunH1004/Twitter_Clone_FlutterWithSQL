import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/database_provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/home_page.dart';
import 'package:twitter_clone/user_info_provider.dart';

class ChangePwdPage extends StatefulWidget {
  const ChangePwdPage({Key? key}) : super(key: key);

  @override
  State<ChangePwdPage> createState() => _PageState();
}

class _PageState extends State<ChangePwdPage> {
  TextEditingController pwdController = TextEditingController();
  TextEditingController pwdController2 = TextEditingController();
  int maxCharacterLimit = 25;

  bool areFieldsEmpty() {
    return pwdController.text.isEmpty || pwdController2.text.isEmpty;
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
              onPressed: areFieldsEmpty()
                  ? null
                  : () async {
                if (pwdController.text == pwdController2.text) {
                  int user_id = context.read<UserInfoProvider>().getUserId();
                  await context.read<DatabaseProvider>().updatePWD(user_id, pwdController.text);
                  Navigator.pop(context, (route) => route.isFirst);
                } else {
                  // 두 비밀번호가 일치하지 않는 경우
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Passwords do not match'),
                    ),
                  );
                  // 텍스트 필드 비우기
                  pwdController.clear();
                  pwdController2.clear();
                }
              },
              child: Center(child: Text("Change", style: MyTextStyles.h3_w)),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  maxLines: 1,
                  controller: pwdController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'new password',
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  obscureText: true,
                  maxLines: 1,
                  controller: pwdController2,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(

                    hintText: 'new password again',
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
