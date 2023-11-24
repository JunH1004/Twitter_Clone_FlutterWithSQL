import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/database_provider.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/user_info_provider.dart';

class FollowBtn extends StatefulWidget {
  FollowBtn(this.hisID);
  int hisID;
  @override
  State<FollowBtn> createState() => _FollowBtnState();
}

class _FollowBtnState extends State<FollowBtn> {
  Future<bool>? amIFollowHim;
  int myId = 0;
  @override
  void initState(){
    super.initState();
    myId = UserInfoProvider().getUserId();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: DatabaseProvider().amIFollowHim(myId, widget.hisID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ElevatedButton(
              style: MyButtonStyles.b1_off,
              onPressed: () { },
              child: Center(
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Container(
              width: 300,
              height: 300,
              color: Colors.red,
            );
          } else if (!snapshot.hasData) {
            return Container(
              width: 300,
              height: 300,
              color: Colors.blue,
            );
          } else {
            bool? amIFollow = snapshot.data;
            return
              amIFollow == false?
              ElevatedButton(
                onPressed: () async {
                  await DatabaseProvider().follow(myId, widget.hisID);
                  setState(() {

                  });
                },
                style: MyButtonStyles.b1,
                child: Text('팔로우',style: MyTextStyles.h3,))
            :
              ElevatedButton(
                  onPressed: () async {
                    await DatabaseProvider().unfollow(myId, widget.hisID);
                    setState(() {

                    });
                  },
                  style: MyButtonStyles.b1_off,
                  child: Text('팔로잉',style: MyTextStyles.h3_w,))
            ;
          }
        },

    );
  }
}
