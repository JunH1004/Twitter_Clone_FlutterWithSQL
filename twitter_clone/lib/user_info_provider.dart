import 'package:flutter/cupertino.dart';
import 'package:twitter_clone/database_provider.dart';

class UserInfoProvider extends ChangeNotifier {
  int _userId = 1;
  String _userName = "Lee";
  int getUserId(){
    return _userId;
  }
  Future<void> setUserId(int n) async {
    _userId = n;
    notifyListeners();
  }
  String getUserName(){
    return _userName;
  }
  void setUserName(String s)  {
    _userName = s;
    notifyListeners();
  }
}