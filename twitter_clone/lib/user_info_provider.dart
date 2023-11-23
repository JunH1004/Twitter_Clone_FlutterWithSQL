import 'package:flutter/cupertino.dart';

class UserInfoProvider extends ChangeNotifier {
  int _userId = -1;
  int getUserId(){
    return _userId;
  }
  void setUserId(int n){
    _userId = n;
    notifyListeners();
  }
}