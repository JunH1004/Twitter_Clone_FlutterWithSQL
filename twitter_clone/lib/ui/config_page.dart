import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/database_provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/change_pwd_page.dart';
import 'package:twitter_clone/ui/home_page.dart';
import 'package:twitter_clone/user_info_provider.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController introController = TextEditingController();

  @override
  void initState(){
    super.initState();
    fetchUserInfo();
  }
  @override
  void dispose() {
    nameController.dispose();
    introController.dispose();
    super.dispose();
  }
  Future<void> fetchUserInfo() async {
    int user_id = context.read<UserInfoProvider>().getUserId();
    Map<String, dynamic> userInfo = await DatabaseProvider().getUserInfo(user_id);
    nameController.text = userInfo['user_name'];
    introController.text = userInfo['intro'] ?? "";

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
              onPressed:() async {
                int user_id = context.read<UserInfoProvider>().getUserId();
                await context.read<DatabaseProvider>().updateUserInfo(user_id, nameController.text, introController.text);
                context.read<UserInfoProvider>().setUserName(nameController.text);
                context.read<UserInfoProvider>().setIntro(introController.text);
                Navigator.pop(context);
              }, // 버튼이 비활성화 상태인 경우 null로 설정
              child: Center(child: Text("Save", style: MyTextStyles.h3_w)),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name', style: MyTextStyles.h3,),
                TextField(
                  maxLines: 1,
                  maxLength: 10,
                  controller: nameController,
                  onChanged: (value) {
                    setState(() {

                    });
                  },
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Intro Text', style: MyTextStyles.h3,),
                TextField(
                  maxLines: 1,
                  maxLength: 25,
                  controller: introController,
                  onChanged: (value) {
                    setState(() {

                    });
                  },
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: 150,
            child: FilledButton(
              style: MyButtonStyles.b3,
              onPressed:() {
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ChangePwdPage()
                ));
              }, // 버튼이 비활성화 상태인 경우 null로 설정
              child: Center(child: Text("Change PWD", style: MyTextStyles.h3_w)),
            ),
          ),
        ],
      ),
    );
  }
}
