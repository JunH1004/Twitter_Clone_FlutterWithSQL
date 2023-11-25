import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/database_provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/user_info_provider.dart';

class FollowBtn extends StatefulWidget {
  FollowBtn(this.hisID, {required this.onUpdate});

  int hisID;
  final Function() onUpdate;

  @override
  State<FollowBtn> createState() => _FollowBtnState();
}

class _FollowBtnState extends State<FollowBtn> {
  Future<bool>? amIFollowHim;
  int myId = 0;

  @override
  void initState() {
    super.initState();
    myId = context.read<UserInfoProvider>().getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: DatabaseProvider().amIFollowHim(myId, widget.hisID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ElevatedButton(
            onPressed: () async {
            },
            style: MyButtonStyles.b1,
            child: Text('Follow', style: MyTextStyles.h3),
          );
        } else if (snapshot.hasError) {
          // 에러 처리 코드
          return ElevatedButton(
            onPressed: () async {
            },
            style: MyButtonStyles.b1,
            child: Text('Follow', style: MyTextStyles.h3),
          );
        } else if (!snapshot.hasData) {
          // 데이터 없음 처리 코드
          return ElevatedButton(
            onPressed: () async {
            },
            style: MyButtonStyles.b1,
            child: Text('Follow', style: MyTextStyles.h3),
          );
        } else {
          bool? amIFollow = snapshot.data;

          return amIFollow == false
              ? ElevatedButton(
            onPressed: () async {
              await DatabaseProvider().follow(myId, widget.hisID);
              widget.onUpdate(); // 팔로우 후 팔로잉 및 팔로워 수 업데이트
              setState(() {});
            },
            style: MyButtonStyles.b1,
            child: Text('Follow', style: MyTextStyles.h3),
          )
              : ElevatedButton(
            onPressed: () async {
              await DatabaseProvider().unfollow(myId, widget.hisID);
              widget.onUpdate(); // 언팔로우 후 팔로잉 및 팔로워 수 업데이트
              setState(() {});
            },
            style: MyButtonStyles.b1_off,
            child: Text('Following', style: MyTextStyles.h3_w),
          );
        }
      },
    );
  }
}
