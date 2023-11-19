import 'package:flutter/material.dart';

var mainTheme = ThemeData(
  primaryColor: MyColors.brown,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
  ),
    iconTheme: IconThemeData(
      color: Colors.black,
    )
);
class MyColors{
  static final brown = Colors.orangeAccent;
  static final red = Color(0xffe52e31);
  static final green = Color(0xff2ee546);
  static final deepRed = Color(0xffbe2022);
  static final grey = Color(0xff2a2a2a);
  static final black = Color(0xff191919);
  static final lightGrey = Color(0xff757575);
  static final BLUE = Color(0xff2e9fe5);
  static final RED = Colors.red;
  static final GREEN = Color(0xff3ae52e);
}
class MyTextStyles{
  static final h1 = TextStyle(color: Colors.black,fontSize: 32,fontWeight: FontWeight.normal);
  static final h2 = TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.normal);
  static final h2_wb = TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold);
  static final h2_o = TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 24,fontWeight: FontWeight.normal);
  static final h2_b = TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold);
  static final h3 = TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal);
  static final h3_w = TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.normal);
  static final h4 = TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.normal);
  static final h4_w = TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.normal);
  
}
class MyButtonStyles{
  static final b1 = FilledButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),
    backgroundColor: mainTheme.primaryColor,
  );
  static final b1_off = FilledButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),
    backgroundColor: MyColors.lightGrey,
  );
  static final b2 = FilledButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),
    backgroundColor: mainTheme.canvasColor,
      side: BorderSide(width: 1, color: Colors.black)
  );
}

class CardStyles{
  static final redCardStyle = BoxDecoration(
    color: MyColors.red,borderRadius:BorderRadius.circular(16),);
  static final normalCardStyle = BoxDecoration(
    color: MyColors.grey,borderRadius:BorderRadius.circular(16),);
  static final lockedCardStyle = BoxDecoration(
    color: MyColors.grey.withOpacity(0.7),borderRadius:BorderRadius.circular(16),);
}

class MyPadding{
  static const double side = 24;
}