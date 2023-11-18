import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/home_page.dart';
import 'package:twitter_clone/ui/signup_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    pwdController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In',style: MyTextStyles.h2,),
        elevation: 0.0,
        backgroundColor: mainTheme.canvasColor,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Form(
              child: Theme(
                data: ThemeData(
                    primaryColor: Colors.grey,
                    focusColor: mainTheme.primaryColor,
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Colors.black, fontSize: 15.0))),
                child: Container(
                    padding: EdgeInsets.all(40.0),
                    // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                    // SingleChildScrollView으로 감싸 줌
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (text){
                              setState(() {

                              });
                            },
                          ),
                          TextField(
                            controller: pwdController,
                            decoration:
                            InputDecoration(labelText: 'Password'),
                            keyboardType: TextInputType.text,
                            obscureText: true, // 비밀번호 안보이도록 하는 것
                            onChanged: (text){
                              setState(() {

                              });
                            },
                          ),
                          SizedBox(height: 40.0,),

                          (emailController.text.isNotEmpty && pwdController.text.isNotEmpty)?
                          FilledButton(
                            style: MyButtonStyles.b1,
                              onPressed: (){
                                print(emailController.text);
                                print(pwdController.text);
                                if(checkLogIn(emailController.text,pwdController.text)){
                                  //로그인 성공
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomePage()));
                                }
                                else{
                                  //로그인 실패
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: MyColors.red,
                                      content: Text('이메일과 비밀번호를 다시 확인하세요',style: MyTextStyles.h3_w,),
                                      action: SnackBarAction(
                                        textColor: MyColors.black,
                                        label: '또는 회원가입',
                                        onPressed: () {
                                          //TODO 회원가입 페이지로 이동
                                        },
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Center(child: Text("로그인",style: MyTextStyles.h3,)))
                          :
                          FilledButton(
                              style: MyButtonStyles.b1_off,
                              onPressed:(){},
                              child: Center(child: Text("로그인",style: MyTextStyles.h3,))
                          )
                          ,

                          Container(
                            width: double.infinity,
                            child: OutlinedButton(

                                onPressed: (){
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SignUpPage()));
                                },
                                child: Text('회원가입',style: MyTextStyles.h3,),
                              style: MyButtonStyles.b2
                            ),
                          )
                        ],
                      ),
                    )),
              ))
        ],
      ),
    );
  }
}

bool checkLogIn(String email, String pwd){
  final String sampleEmail = "qwer";
  final String samplePwd = "qwer";
  print(sampleEmail.compareTo(email));
  if (sampleEmail.compareTo(email) == 0 && samplePwd.compareTo(pwd) == 0){
    return true;
  }
  return false;
}

