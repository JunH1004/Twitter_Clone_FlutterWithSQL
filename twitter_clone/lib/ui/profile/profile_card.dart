import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/database_provider.dart';
import 'package:twitter_clone/ui/profile/profile_page.dart';

import '../../main_style.dart';
import '../homepage_tabs/search_tab.dart';

class ProfileCard extends StatefulWidget {
  ProfileCard(this.userID);
  int userID;
  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: DatabaseProvider().getUserInfo(widget.userID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('userInfo : ');
          return Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          );
        } else {
          Map<String, dynamic> userInfo = snapshot.data!;
          print('userInfo : $userInfo');// 업데이트 콜백 호출
          return Row(
            children: [
              Image.asset('assets/DogeCoin.png',width: 64, height: 64,),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProfilePage(widget.userID, userInfo['user_name'])
                    )
                    );
                  },
                  child: Text(userInfo['user_name'], style: MyTextStyles.h2_b,)
              )

            ],
          );
        }
      },
    );
  }
}
