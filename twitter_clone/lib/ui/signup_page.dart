import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/main_style.dart';
import 'package:twitter_clone/ui/home_page.dart';
import 'package:twitter_clone/ui/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController pwdController2 = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    pwdController.dispose();
    pwdController2.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up',style: MyTextStyles.h2,),
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
                            controller: nameController,
                            decoration: InputDecoration(labelText: 'Name'),
                            keyboardType: TextInputType.name,
                            onChanged: (text){
                              setState(() {

                              });
                            },
                          ),
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
                          TextField(
                            controller: pwdController2,
                            decoration:
                            InputDecoration(labelText: 'Password Again'),
                            keyboardType: TextInputType.text,
                            obscureText: true, // 비밀번호 안보이도록 하는 것
                            onChanged: (text){
                              setState(() {

                              });
                            },
                          ),
                          SizedBox(height: 40.0,),

                          (emailController.text.isNotEmpty && pwdController.text.isNotEmpty&& pwdController2.text.isNotEmpty)?
                          FilledButton(
                              style: MyButtonStyles.b1,
                              onPressed: (){
                                if(checkSamePwd(pwdController.text,pwdController2.text)){
                                  signUp(nameController.text,emailController.text, pwdController.text);
                                  //회원가입 성공
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: MyColors.green,
                                      content: Text('Welcome',style: MyTextStyles.h3_w,),
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              LogInPage()));
                                }
                                else{
                                  //회원가입 실패
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: MyColors.red,
                                      content: Text('비밀번호를 다시 확인하세요',style: MyTextStyles.h3_w,),
                                    ),
                                  );
                                }
                              },
                              child: Center(child: Text("회원가입",style: MyTextStyles.h3,)))
                              :
                          FilledButton(
                            style: MyButtonStyles.b1,
                              onPressed:(){},
                              child: Center(child: Text("회원가입",style: MyTextStyles.h3,))
                          ),
                        ],
                      ),
                    )),
              ))
        ],
      ),
    );
  }
}

bool checkSamePwd(String pwd, String pwd1){
  if(pwd == pwd1){
    return true;
  }
  return false;
}
void signUp(String name, String email, String pwd){
  print('회원가입 : $name, $email, $pwd');
}

