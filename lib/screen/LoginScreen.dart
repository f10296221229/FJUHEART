import 'package:devtest01/screen/ForgetScreen.dart';
import 'package:devtest01/screen/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Icon/MyFlutterApp.dart';
import '../model/login_model.dart';
import '../service/login_database_helper.dart';
import 'Home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

//监听账号输入框的文字变化
final TextEditingController _accountController = TextEditingController();
//监听密码输入框的文字变化
final TextEditingController _passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  //用于登录时判断输入的账号、密码是否符合要求

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Colors.cyan,
          automaticallyImplyLeading: false,
          title: const Text('AI警示系統登入',style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
        ),
        body: ListView(
          children: const [
            //  Image.asset(
            //   'images/lake.jpg',
            //   width: 600,
            //   height: 240,
            //   //cover(充满容器)、fill（充满父容器）、contain（总有宽或高跟父一样）、none(原图居中显示)、fitWidth（宽度跟父一样）、fitHeight（高度跟父一样）
            //   fit: BoxFit.contain,
            // ),
            TextSection(),
            LoginButton(),
            ForgetButton(),
            // Icon(MyFlutterApp.power_button),
            // TestButton()
          ],
        ));
        // ,bottomNavigationBar: BottomNavigationBar(items: const [],));
  }
}


class TestButton extends StatelessWidget {
  const TestButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      // 水平讓各自 Container 間有間距
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // 垂直靠下
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(50, 20, 0, 20),
              // color: Colors.red,
              child: ElevatedButton(
                //一个凸起的材质矩形按钮
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    elevation: 0,
                  ),
                  // color: Colors.red,
                  child: const Text(
                    '測試首頁',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 94, 255, 1.0),
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/test');
                  }))
        ]);
  }
}

class TextSection extends StatelessWidget {
  const TextSection({super.key});

  //账号输入框样式
  static Widget buildAccountTextFied(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: TextField(
        //键盘的样式
        keyboardType: TextInputType.text,
        //监听
        controller: controller,
        //最大长度
        // maxLength: 30,
        //颜色跟hintColor
        //最大行数
        maxLines: 1,
        //是否自动更正
        autocorrect: true,
        //是否自动化对焦
        autofocus: false,
        //是否是密码格式(输入的内容不可见)
        obscureText: false,
        //文本对齐方式
        textAlign: TextAlign.start,
        //输入文本的样式
        style: const TextStyle(fontSize: 20, color: Colors.black),
        //允许输入的格式(digitsOnly数字)
        // inputFormatters: [
        //   FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
        // ],
        //内容改变回调
        onChanged: (account) {
          // print('change $account');
        },
        //提交触发回调
        onSubmitted: (account) {
          // print('submit $account');
        },
        //是否禁用
        enabled: true,
        decoration: InputDecoration(
            fillColor: Colors.blue[50],
            //底色
            filled: true,
            //有聚焦，labelText就会缩小到输入框左上角，颜色primaryColor，没聚焦前颜色跟hintColor
            // labelText: '帳號',
            //聚焦时才显示,颜色跟hintColor
            hintText: '請輸入帳號',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '帳號：',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            //输入框内右侧的widget
            suffixIcon: const Icon(Icons.account_circle),
//            有聚焦显示颜色跟hintColor，显示在输入框的右边
//             suffixText: "后缀",
            contentPadding: const EdgeInsets.all(5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
              borderSide: const BorderSide(
                  color: Colors.black,
                  width: 25.0), //边框颜色、大小没有效果，所以使用返回的是Theme，
            )),
      ),
    );
  }

  //密码输入框样式
  static Widget buildPasswordTextFied(TextEditingController controller) {
    return TextField(
      //键盘的样式
      keyboardType: TextInputType.text,
      //监听
      controller: controller,
      //最大长度
      // maxLength: 10,
      //颜色跟hintColor
      //最大行数
      maxLines: 1,
      //是否自动更正
      autocorrect: true,
      //是否自动化对焦
      autofocus: false,
      //是否是密码格式(输入的内容不可见)
      obscureText: true,
      //文本对齐方式
      textAlign: TextAlign.start,
      //输入文本的样式
      style: const TextStyle(fontSize: 20, color: Colors.black),
      //允许输入的格式(digitsOnly数字)
      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
      // ],
      //内容改变回调
      onChanged: (password) {
        // print('change $password');
      },
      //提交触发回调
      onSubmitted: (password) {
        // print('submit $password');
      },
      //是否禁用
      enabled: true,
      decoration: InputDecoration(
          //底色配合filled：true才有效
          fillColor: Colors.blue[50],
          filled: true,
          //输入聚焦以后，labelText就会缩小到输入框左上角，红色,没聚焦前颜色跟hintColor
          // labelText: '密碼',
          //聚焦时才显示,颜色跟hintColor
          hintText: '請輸入密碼',
          //红色
//          errorText: '输入错误',
          //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//          helperText: 'password',
          //输入框内左侧widget，输入聚焦时，颜色跟primaryColor
          prefixIcon: const Icon(Icons.lock),
          //输入框左侧的widget（可是text、icon……）
          icon: const Text(
            '密碼：',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          //输入框内右侧的widget
          suffixIcon: const Icon(Icons.remove_red_eye),
          //聚焦时才显示颜色跟hintColor，显示在输入框的右边
          // suffixText: '后缀',
          contentPadding: const EdgeInsets.all(5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
            borderSide: const BorderSide(
                color: Colors.black, width: 25.0), //没有效果，想要修改就返回Theme（如前面账号样式）
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        //主轴Flex的值
        mainAxisSize: MainAxisSize.max,
        //MainAxisAlignment：主轴方向上的对齐方式，会对child的位置起作用
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildAccountTextFied(_accountController),
          buildPasswordTextFied(_passwordController),
        ],
      ),
    );
  }
}



class ForgetButton extends StatelessWidget {
  const ForgetButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      // 水平讓各自 Container 間有間距
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // 垂直靠下
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(50, 20, 0, 20),
              // color: Colors.red,
              child: ElevatedButton(
                //一个凸起的材质矩形按钮
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    elevation: 0,
                  ),
                  // color: Colors.red,
                  child: const Text(
                    '忘記密碼?',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 94, 255, 1.0),
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const ForgetScreen();
                        }));
                    // Navigator.pushNamed(context, '/FORGET');
                  }))
          // ,style: TextStyle(color: Color.fromRGBO(0, 94, 255, 1.0),fontSize: 20),

          ,
          Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 50, 20),
              // color: Colors.red,
              child: ElevatedButton(
                //一个凸起的材质矩形按钮
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                    elevation: 0,
                  ),
                  // color: Colors.red,
                  child: const Text(
                    '申請會員',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 94, 255, 1.0),
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const RegisterScreen();
                        }));
                    // Navigator.pushNamed(context, '/Register');
                  })),
        ]);
  }
}


class LoginButton extends StatelessWidget {
  const LoginButton({super.key});
  static bool _accountState = false, _passwordState = false;
  static String _checkHint = "";

  static void _checkAccount() {
    if (_accountController.text.isNotEmpty) {
      _accountState = true;
    } else {
      _accountState = false;
    }
  }

  static void _checkPassword() {
    if (_passwordController.text.isNotEmpty) {
      _passwordState = true;
    } else {
      _passwordState = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 35, right: 35),
        //这个widget距离父控件左右35（还有个all就是距离左上右下四个方向）
        child: SizedBox(
            //用来设置宽高，如直接使用RaisedButton则不能设置
            height: 50,
            child: ElevatedButton(
                //一个凸起的材质矩形按钮
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                // color: Colors.red,
                child: const Text(
                  '登入',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () async {
                  _checkAccount();
                  _checkPassword();
                  if (_accountState) {
                    if (_passwordState) {
                      // Navigator.pushNamed(context, '/Home');
                      // ignore: prefer_interpolation_to_compose_strings
                      // _checkHint = _accountController.text.toString() + "登入成功";
                    } else {
                      _checkHint = '請輸入密碼！';
                    }
                  } else {
                    _checkHint = '請輸入帳號!';
                  }

                  if (_accountState && _passwordState) {
                    var f = await resp(
                        _accountController.text, _passwordController.text);
                    if (f == "Y") {


                      // WidgetBuilder builder;
                      // builder = (_) => const Home();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const Home();
                          }));

                      final account = _accountController.value.text;
                      final password = _passwordController.value.text;
                      final now = DateTime.now().toString();
                      final Login model = Login(
                          account: account, password: password, logindt: now);
                      DatabaseHelper.addNote(model);

                      _accountController.clear();
                      _passwordController.clear();
                    } else {
                      _dialogBuilder(context, f.toString(), true, false);
                    }
                  } else {
                    _dialogBuilder(
                        context, _checkHint, _accountState, _passwordState);
                  }
                })));
  }
}

Future resp(String account, String password) async {
  String flag = "";
  final response = await http.post(
    Uri.parse('http://211.20.21.35:8080/fjuheart/doMobilelogin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Access-Control-Allow-Origin': '*',
    },
    body: jsonEncode(<String, String>{
      "Account": account,
      "Password": password,
      "verifyCode": "",
      "Loginmode": ""
    }),
  );

  if (response.statusCode == 200) {
    if (jsonDecode(response.body)["status"] == "Success") {
      flag = "Y";
    } else {
      flag = "帳號密碼錯誤";
    }
  } else {
    flag = "連線失敗";
  }

  return flag;
}

Future<void> _dialogBuilder(BuildContext context, String checkHint,
    bool accountState, bool passwordState) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          '錯誤',
          style: TextStyle(color: Colors.red[300], fontSize: 18),
        ),
        content: Text(checkHint),
        actions: <Widget>[
          // TextButton(//一个扁平的Material按钮
          //     onPressed: () {
          //       Navigator.of(context).pop();//弹窗消失
          //     },
          //     child: const Text('取消')),
          TextButton(
              onPressed: () {
                if (accountState && passwordState) {
                  //账号密码都符合条件
                  Navigator.pushNamed(context,
                      '/Home'); //使用的是“命名导航路由”，具体去哪个界面，看main.dart 对应routeName（'/Home'）的界面
                } else {
                  Navigator.of(context).pop(); //弹窗消失
                }
              },
              child: const Text('確定')),
        ],
      );
    },
  );
}
