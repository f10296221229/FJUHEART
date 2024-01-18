import 'package:devtest01/screen/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/login_model.dart';
import '../service/login_database_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}


//监听账号输入框的文字变化
final TextEditingController _accountController = TextEditingController();
//监听密码输入框的文字变化
final TextEditingController _passwordController = TextEditingController();

final TextEditingController _phoneController = TextEditingController();

final TextEditingController _mailController = TextEditingController();

final TextEditingController _confirmpasswordController = TextEditingController();

class _RegisterScreenState extends State<RegisterScreen> {
  //用于登录时判断输入的账号、密码是否符合要求

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Colors.cyan,
          automaticallyImplyLeading: false,
          title: const Text('註冊',
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))
          ),

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
            ForgetButton()
          ],
        ));
  }
}

//回首頁
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
          margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
           child: const Text(
             '已經註冊了嗎?',
             style: TextStyle(
                 color: Color.fromRGBO(0, 0, 0, 1.0),
                 fontSize: 20),
           ),
         ),
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 70, 0),
            child: ElevatedButton(
              //一个凸起的材质矩形按钮
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0, 20, 50, 0),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),
                child: const Text(
                  '按此登入',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 94, 255, 1.0),
                      fontSize: 20),
                ),
                onPressed: () {
                  _accountController.clear();
                  _phoneController.clear();
                  _mailController.clear();
                  _passwordController.clear();
                  _confirmpasswordController.clear();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const LoginScreen();
                      }));
                  // Navigator.pushNamed(context, '/');

                }))
        // ,style: TextStyle(color: Color.fromRGBO(0, 94, 255, 1.0),fontSize: 20),

        ,

        //     margin: const EdgeInsets.fromLTRB(0, 20, 50, 20),
        //     // color: Colors.red,
        //     child: ElevatedButton(
        //       //一个凸起的材质矩形按钮
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.transparent,
        //           foregroundColor: Colors.black,
        //           elevation: 0,
        //         ),
        //         // color: Colors.red,
        //         child: const Text(
        //           '申請會員',
        //           style: TextStyle(
        //               color: Color.fromRGBO(0, 94, 255, 1.0),
        //               fontSize: 20),
        //         ),
        //         onPressed: () {})),
        ]);
  }
}

class TextSection extends StatelessWidget {
   const TextSection({super.key});



  //姓名
  static Widget buildNameTextField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
            hintText: '請輸入姓名',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            // prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '姓名：',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            //输入框内右侧的widget
            // suffixIcon: const Icon(Icons.account_circle),
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

  //手機
  static Widget buildPhoneTextField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: TextField(
        //键盘的样式
        keyboardType: TextInputType.phone,
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
        obscureText: false,
        //文本对齐方式
        textAlign: TextAlign.start,
        //输入文本的样式
        style: const TextStyle(fontSize: 20, color: Colors.black),
        //允许输入的格式(digitsOnly数字)
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
        ],
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
            hintText: '請輸入手機',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            // prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '手機：',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            //输入框内右侧的widget
            // suffixIcon: const Icon(Icons.account_circle),
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

  //郵件
  static Widget buildMailTextField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
        style: const TextStyle(fontSize: 16, color: Colors.black),
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
            hintText: '請輸入電子信箱',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            // prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '信箱：',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
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

  //密碼
  static Widget buildPasswordTextField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: TextField(
        obscureText: true,
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
        // obscureText: false,
        //文本对齐方式
        textAlign: TextAlign.start,
        //输入文本的样式
        style: const TextStyle(fontSize: 14, color: Colors.black),
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
            hintText: '至少8個字及一個大寫字母,小寫字母,數字',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            // prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '密碼：',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            //输入框内右侧的widget
            // suffixIcon: const Icon(Icons.account_circle),
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

  //確認密碼
  static Widget buildConfirmPasswordTextField(
      TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: TextField(
        obscureText: true,
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
        // obscureText: false,
        //文本对齐方式
        textAlign: TextAlign.start,
        //输入文本的样式
        style: const TextStyle(fontSize: 16, color: Colors.black),
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
            hintText: '請輸入確認密碼',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            // prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '確認密碼：',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            //输入框内右侧的widget
            // suffixIcon: const Icon(Icons.account_circle),
//            有聚焦显示颜色跟hintColor，显示在输入框的右边
//             suffixText: "后缀",
            contentPadding: const EdgeInsets.all(3),
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
//   static Widget buildPasswordTextFiled(TextEditingController controller) {
//     return TextField(
//       //键盘的样式
//       keyboardType: TextInputType.text,
//       //监听
//       controller: controller,
//       //最大长度
//       // maxLength: 10,
//       //颜色跟hintColor
//       //最大行数
//       maxLines: 1,
//       //是否自动更正
//       autocorrect: true,
//       //是否自动化对焦
//       autofocus: false,
//       //是否是密码格式(输入的内容不可见)
//       obscureText: true,
//       //文本对齐方式
//       textAlign: TextAlign.start,
//       //输入文本的样式
//       style: const TextStyle(fontSize: 20, color: Colors.black),
//       //允许输入的格式(digitsOnly数字)
//       // inputFormatters: [
//       //   FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
//       // ],
//       //内容改变回调
//       onChanged: (password) {
//         // print('change $password');
//       },
//       //提交触发回调
//       onSubmitted: (password) {
//         // print('submit $password');
//       },
//       //是否禁用
//       enabled: true,
//       decoration: InputDecoration(
//         //底色配合filled：true才有效
//           fillColor: Colors.blue[50],
//           filled: true,
//           //输入聚焦以后，labelText就会缩小到输入框左上角，红色,没聚焦前颜色跟hintColor
//           // labelText: '密碼',
//           //聚焦时才显示,颜色跟hintColor
//           hintText: '請輸入密碼',
//           //红色
// //          errorText: '输入错误',
//           //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
// //          helperText: 'password',
//           //输入框内左侧widget，输入聚焦时，颜色跟primaryColor
//           prefixIcon: const Icon(Icons.lock),
//           //输入框左侧的widget（可是text、icon……）
//           icon: const Text(
//             '密碼：',
//             style: TextStyle(fontSize: 20, color: Colors.black),
//           ),
//           //输入框内右侧的widget
//           suffixIcon: const Icon(Icons.remove_red_eye),
//           //聚焦时才显示颜色跟hintColor，显示在输入框的右边
//           // suffixText: '后缀',
//           contentPadding: const EdgeInsets.all(5),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
//             borderSide: const BorderSide(
//                 color: Colors.black, width: 25.0), //没有效果，想要修改就返回Theme（如前面账号样式）
//           )),
//     );
//   }

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
          buildNameTextField(_accountController),
          buildPhoneTextField(_phoneController),
          buildMailTextField(_mailController),
          buildPasswordTextField(_passwordController),
          buildConfirmPasswordTextField(_confirmpasswordController),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  static bool _accountState = false
      ,_phoneState = false
      ,_mailState = false
      ,_passwordState = false
      ,_confirmpasswordState = false
  ;
  static String _checkHint = "";

  static void _phone() {
    if (_phoneController.text.isEmpty) {
      _checkHint = '手機輸入不為空!';
      _phoneState = true;
    } else {
      if(_phoneController.text.length!=10){
        _checkHint = '手機輸入不為10碼!';
        _phoneState = true;
      }else{
        RegExp phone = RegExp(r'^09\d{8}$');
        if(phone.hasMatch(_phoneController.text)==false){
          _checkHint = '手機輸入為09開頭及10碼數字!';
          _phoneState = true;
        }else{
          _phoneState = false;
        }
      }
    }
  }

  static void _mail() {
    if (_mailController.text.isEmpty) {
      _checkHint = '信箱輸入不為空!';
      _mailState = true;
    } else {
      RegExp phone = RegExp(r'^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$');
      if(phone.hasMatch(_mailController.text)==false){
        _checkHint = '須符合信箱格式!';
        _mailState = true;
      }else{
        _mailState = false;
      }
    }
  }

  static void _checkAccount() {
    if (_accountController.text.isEmpty) {
      _checkHint = '姓名不為空!';
      _accountState = true;
    } else {
      _accountState = false;
    }
  }


  static void _password() {
    if (_passwordController.text.isEmpty) {
      _passwordState = true;
      _checkHint = '密碼不為空!';
    } else {
      if(_passwordController.text.length<8){
        _passwordState = true;
        _checkHint = '密碼需大於8碼!';
      }else{
        RegExp phone = RegExp(r'[a-z]');
        if(phone.hasMatch(_passwordController.text)==false){
          _checkHint = '密碼應至少包含 8 個字元,包括至少一個大寫字母和一個小寫字母,和一個數字!';
          _passwordState = true;
        }else{
          phone = RegExp(r'[A-Z]');
          if(phone.hasMatch(_passwordController.text)==false){
            _checkHint = '密碼應至少包含 8 個字元,包括至少一個大寫字母和一個小寫字母,和一個數字!';
            _passwordState = true;
          }else{
            phone = RegExp(r'[0-9]');
            if(phone.hasMatch(_passwordController.text)==false){
              _checkHint = '密碼應至少包含 8 個字元,包括至少一個大寫字母和一個小寫字母,和一個數字!';
              _passwordState = true;
            }else{
              _passwordState = false;
            }
          }
        }
      }
    }
  }

  static void _confirmpassword() {
    if (_confirmpasswordController.text.isEmpty) {
      _confirmpasswordState = true;
      _checkHint = '確認密碼不為空!';
    } else {
      if (_passwordController.text !=_confirmpasswordController.text) {
        _confirmpasswordState = true;
        _checkHint = '確認密碼須和密碼相同!';
      }else{
        _confirmpasswordState = false;
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 35, right: 35),
        child: SizedBox(
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(51, 204, 204, 1.0)),
                child: const Text(
                  '註冊',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () async {

                   _checkAccount();
                  if (_accountState) {
                    await _dialogBuilder(context, _checkHint);
                    return;
                  }

                  _phone();
                  if (_phoneState) {
                    await _dialogBuilder(context, _checkHint);
                    return;
                  }
                  _mail();
                  if (_mailState) {
                    await _dialogBuilder(context, _checkHint);
                    return;
                  }

                  _password();
                  if (_passwordState) {
                    await _dialogBuilder(context, _checkHint);
                    return;
                  }
                  _confirmpassword();
                  if (_confirmpasswordState) {
                    await _dialogBuilder(context, _checkHint);
                    return;
                  }



                   var f = await resp(
                       _accountController.text
                       ,_phoneController.text
                       ,_mailController.text
                       ,_passwordController.text
                   );


                    if (f == "Y") {
                      _dialogBuilder1(context, "註冊完成");
                    } else {
                      _dialogBuilder(context, f);
                    }
                  }

                )));
  }
}

Future resp(String userName,String PHONE,String EMAIL,String userPasswordEnc) async {
  String flag = "";
  final response = await http.post(
    Uri.parse('http://211.20.21.35:8080/fjuheart/MH100201/insert11'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Access-Control-Allow-Origin': '*',
    },
    body: jsonEncode(<String, String>{
      "EMAIL": EMAIL
      ,"USER_PASSWORD_ENC": userPasswordEnc
      ,"USER_NAME": userName
      ,"TELEPHONE": PHONE
      // EMAIL: $("#EMAIL").val()
      // , USER_PASSWORD_ENC: $("#USER_PASSWORD_ENC").val()
      // , USER_NAME: $("#USER_NAME").val()
      // , TELEPHONE: $("#TELEPHONE").val()
    }),
  );

  if (response.statusCode == 200) {
    if (jsonDecode(response.body)["RETURNVALUE"] == "Y") {
      flag = "Y";
    } else {
      flag = jsonDecode(response.body)["RETURNMSG"];
    }
  } else {
    flag = "連線失敗";
  }


  return flag;
}

Future<void> _dialogBuilder(BuildContext context, String checkHint) {
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
                // if (accountState && passwordState) {
                //   //账号密码都符合条件
                //   // Navigator.pushNamed(context, '/Home'); //使用的是“命名导航路由”，具体去哪个界面，看main.dart 对应routeName（'/Home'）的界面
                // } else {
                Navigator.of(context).pop(); //弹窗消失
                // }
              },
              child: const Text('確定')),
        ],
      );
    },
  );
}
Future<void> _dialogBuilder1(BuildContext context, String checkHint) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '成功',
          style: TextStyle(color: Colors.greenAccent, fontSize: 18),
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

                _accountController.clear();
                _phoneController.clear();
                _mailController.clear();
                _passwordController.clear();
                _confirmpasswordController.clear();


                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const LoginScreen();
                    }));
                // if (accountState && passwordState) {
                //   //账号密码都符合条件
                //   Navigator.pushNamed(context, '/'); //使用的是“命名导航路由”，具体去哪个界面，看main.dart 对应routeName（'/Home'）的界面
                // } else {
                // Navigator.of(context).pop(); //弹窗消失
                // }
              },
              child: const Text('確定')),
        ],
      );
    },
  );
}