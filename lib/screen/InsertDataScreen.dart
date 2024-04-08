import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../model/login_model.dart';
import '../service/login_database_helper.dart';
import 'JsonDataGrid.dart';
import 'dart:io';
import 'UpdateDataScreen.dart';

// late String TRANSACTION_SEQ1 = "";
late StringBuffer buffer = StringBuffer('');

File? _imageFile;
late String MEASURE_DT_S = "";
late String MEASURE_DT_E = "";

class InsertDataScreen extends StatefulWidget {
  InsertDataScreen({required this.MEASURE_DT_S1,required this.MEASURE_DT_E1});

  final String MEASURE_DT_S1;
  final String MEASURE_DT_E1;

  @override
  State<InsertDataScreen> createState() {
    return _InsertDataScreenState(MEASURE_DT_S1,MEASURE_DT_E1);
  }
}

//监听账号输入框的文字变化
final TextEditingController _accountController = TextEditingController();
//监听密码输入框的文字变化
final TextEditingController _passwordController = TextEditingController();

final TextEditingController _phoneController = TextEditingController();

final TextEditingController _mailController = TextEditingController();

final TextEditingController _confirmpasswordController = TextEditingController();

final TextEditingController _spo2Controller = TextEditingController();

final FocusNode aFocus = FocusNode();
final FocusNode bFocus = FocusNode();
final FocusNode cFocus = FocusNode();
final FocusNode dFocus = FocusNode();
final FocusNode eFocus = FocusNode();
final FocusNode fFocus = FocusNode();

class _InsertDataScreenState extends State<InsertDataScreen> {

  _InsertDataScreenState(this.MEASURE_DT_S2,this.MEASURE_DT_E2);

  final String MEASURE_DT_S2;
  final String MEASURE_DT_E2;

  @override
  void initState() {

    MEASURE_DT_S=MEASURE_DT_S2;
    MEASURE_DT_E=MEASURE_DT_E2;

    _accountController.text="";
    _passwordController.text="";
    _phoneController.text="";
    _mailController.text="";
    _confirmpasswordController.text="";
    _spo2Controller.text="";
    _imageFile = null;
    // main();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return  JsonDataGrid(Measure_s: MEASURE_DT_S2, Measure_e: MEASURE_DT_E2,);
                    }));
              }),
          // backgroundColor:  Colors.cyan,
          // automaticallyImplyLeading: false,
          title: const Text(
            '生理指標',
            // style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))
          ),
        ),
        body: ListView(
          children: const [
            InsertTextSection(),
            // ImagePickerScreen(),
            InsertButton(),
            // ForgetButton()
          ],
        ));
  }
}


class InsertButton extends StatefulWidget {
  const InsertButton({Key? key}) : super(key: key);

  // final String title;
  @override
  createState() => _InsertButtonState();
}

//儲存
class _InsertButtonState extends State<InsertButton> {
  // const _InsertButtonState({super.key});

  @override
  void initState() {

  }

  late BuildContext dialogContext;

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dialogContext = context;
          return LoadingDialog(true);
        });
  }

  static bool _accountState = false,
      _phoneState = false,
      _mailState = false,
      _passwordState = false,
      _confirmpasswordState = false,
      _Spo2State = false;
  static String _checkHint = "";


  static void _phone() {
    if (_phoneController.text.isEmpty) {
      _checkHint = '心跳不為空!';
      _phoneState = true;
    } else {
      if (int.tryParse(_phoneController.text) == null) {
        _checkHint = '心跳請輸入(整數)格式!';
        _phoneState = true;
      } else {
        _phoneState = false;
      }
    }
  }

  static void _mail() {
    if (_mailController.text.isEmpty) {
      _checkHint = '呼吸不為空!';
      _mailState = true;
    } else {
      if (int.tryParse(_mailController.text) == null) {
        _checkHint = '呼吸請輸入(整數)格式!';
        _mailState = true;
      } else {
        _mailState = false;
      }
    }

  }

  static void _checkAccount() {
    if (_accountController.text.isEmpty) {
      _checkHint = '體溫不為空!';
      _accountState = true;
    } else {
      if (double.tryParse(_accountController.text) == null) {
        _checkHint = '體溫請輸入(整數)格式!';
        _accountState = true;
      } else {
        _accountState = false;
      }
    }
  }

  static void _password() {
    if (_passwordController.text.isEmpty) {
      _checkHint = '收縮壓不為空!';
      _passwordState = true;
    } else {
      if (int.tryParse(_passwordController.text) == null) {
        _checkHint = '收縮壓請輸入(整數)格式!';
        _passwordState = true;
      } else {
        _passwordState = false;
      }
    }


  }

  static void _confirmpassword() {
    if (_confirmpasswordController.text.isEmpty) {
      _checkHint = '舒張壓不為空!';
      _confirmpasswordState = true;
    } else {
      if (int.tryParse(_confirmpasswordController.text) == null) {
        _checkHint = '舒張壓請輸入(整數)格式!';
        _confirmpasswordState = true;
      } else {
        _confirmpasswordState = false;
      }
    }

  }

  static void _spo2word() {
    if (_spo2Controller.text.isEmpty) {
      _checkHint = '血氧不為空!';
      _Spo2State = true;
    } else {
      if (int.tryParse(_spo2Controller.text) == null) {
        _checkHint = '血氧請輸入(整數)格式!';
        _Spo2State = true;
      } else {
        _Spo2State = false;
      }
    }
  }

  static void _flag() {
    if (double.parse(_accountController.text)>39.1) {
      buffer.write("體溫 ${_accountController.text} 大於 39.1 確定要儲存嗎?\n");
    }
    if (double.parse(_accountController.text)<35.0) {
      buffer.write("體溫 ${_accountController.text} 小於 35.0 確定要儲存嗎?\n");
    }
    if (int.parse(_phoneController.text)>131) {
      buffer.write("心跳 ${_phoneController.text} 大於 131 確定要儲存嗎?\n");
    }
    if (int.parse(_phoneController.text)<40) {
      buffer.write("心跳 ${_phoneController.text} 小於 40 確定要儲存嗎?\n");
    }
    if (int.parse(_mailController.text)>25) {
      buffer.write("呼吸 ${_mailController.text} 大於 25 確定要儲存嗎?\n");
    }
    if (int.parse(_mailController.text)<8) {
      buffer.write("呼吸 ${_mailController.text} 小於 8 確定要儲存嗎?\n");
    }
    if (int.parse(_passwordController.text)>220) {
      buffer.write("收縮壓 ${_passwordController.text} 大於 220 確定要儲存嗎?\n");
    }
    if (int.parse(_passwordController.text)<90) {
      buffer.write("收縮壓 ${_passwordController.text} 小於 90 確定要儲存嗎?\n");
    }
    if (int.parse(_confirmpasswordController.text)>120) {
      buffer.write("舒張壓 ${_confirmpasswordController.text} 大於 120 確定要儲存嗎?\n");
    }
    if (int.parse(_confirmpasswordController.text)<50) {
      buffer.write("舒張壓 ${_confirmpasswordController.text} 小於 50 確定要儲存嗎?\n");
    }
    if (int.parse(_confirmpasswordController.text)>120) {
      buffer.write("舒張壓 ${_confirmpasswordController.text} 大於 120 確定要儲存嗎?\n");
    }
    if (int.parse(_spo2Controller.text)>101) {
      buffer.write("血氧 ${_spo2Controller.text} 大於 101 確定要儲存嗎?\n");
    }

    if (int.parse(_spo2Controller.text)<88) {
      buffer.write("血氧 ${_spo2Controller.text} 小於 88 確定要儲存嗎?\n");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // 水平讓各自 Container 間有間距
        mainAxisAlignment: MainAxisAlignment.center,
        // 垂直靠下
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: ElevatedButton(
                //一个凸起的材质矩形按钮
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black,
                    elevation: 0,
                      minimumSize: Size(MediaQuery.of(context).size.width - 20, 40)
                  ),
                  child: const Text(
                    '儲存',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1.0),
                        fontSize: 20),
                  ),
                  onPressed: () async {
                    _checkAccount();
                    if (_accountState) {
                      await _dialogBuilder(context, _checkHint, "A");
                      return;
                    }
                    _phone();
                    if (_phoneState) {
                      await _dialogBuilder(context, _checkHint, "B");
                      return;
                    }
                    _mail();
                    if (_mailState) {
                      await _dialogBuilder(context, _checkHint, "C");
                      return;
                    }
                    _password();
                    if (_passwordState) {
                      await _dialogBuilder(context, _checkHint, "D");
                      return;
                    }
                    _confirmpassword();
                    if (_confirmpasswordState) {
                      await _dialogBuilder(context, _checkHint, "E");
                      return;
                    }
                    _spo2word();
                    if (_Spo2State) {
                      await _dialogBuilder(context, _checkHint, "F");
                      return;
                    }

                    if (_imageFile == null) {
                      _dialogBuilder( context,"無上傳照片","X");
                      return;
                    }


                    _flag();

                    if(buffer.toString().isNotEmpty){
                      _dialogBuilder2(context, buffer.toString());
                      return;
                    }

                    _showDialog();
                     var f = await resp();
                      if (f == "Y") {
                        Navigator.pop(dialogContext);
                        _dialogBuilder1(context, "新增完成");
                        buffer.clear();
                      } else {
                        Navigator.pop(dialogContext);
                        _dialogBuilder(context, f,"X");
                        buffer.clear();
                      }
                  }
              )
          ),
        ]);
  }
}

class InsertTextSection extends StatefulWidget {
  const InsertTextSection({Key? key}) : super(key: key);
  // final String title;
  @override
  createState() => _InsertTextSectionState();
}

class _InsertTextSectionState extends State<InsertTextSection> {
  // const _InsertTextSectionState({super.key});

   void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  //體溫
  static Widget buildNameTextField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: TextField(

        //键盘的样式
        keyboardType: TextInputType.number,
        //监听
        controller: controller,
        //最大长度
        // maxLength: 30,
        //颜色跟hintColor
        //最大行数
        maxLines: 1,
        //是否自动更正
        autocorrect: true,
        focusNode: aFocus,
        //是否自动化对焦
        autofocus: false,
        //是否是密码格式(输入的内容不可见)
        obscureText: false,
        //文本对齐方式
        textAlign: TextAlign.start,
        //输入文本的样式
        style: const TextStyle(fontSize: 14, color: Colors.black),
        //允许输入的格式(digitsOnly数字)
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
        ],
        //内容改变回调
        onChanged: (account) {
          // print('change $account');
        },
        //提交触发回调
        // onSubmitted: (account) {
        //   // print('submit $account');
        // },
        //是否禁用
        enabled: true,
        decoration: InputDecoration(
            fillColor: Colors.blue[50],
            //底色
            filled: true,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            //有聚焦，labelText就会缩小到输入框左上角，颜色primaryColor，没聚焦前颜色跟hintColor
            // labelText: '帳號',
            //聚焦时才显示,颜色跟hintColor
            // hintText: '請輸入姓名',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            // prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '體溫(°C) ',
              style: TextStyle(fontSize: 14, color: Colors.black
              ),

            ),
            //输入框内右侧的widget
            // suffixIcon: const Icon(Icons.account_circle),
//            有聚焦显示颜色跟hintColor，显示在输入框的右边
//             suffixText: "后缀",
            isDense: true,
            contentPadding: const EdgeInsets.all(8),
            border: const OutlineInputBorder(
              // borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
              borderSide: BorderSide(
                  color: Colors.black,
                  width: 25.0), //边框颜色、大小没有效果，所以使用返回的是Theme，
            )),
      ),
    );
  }

  //心跳(次/分)
  static Widget buildPhoneTextField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: TextField(
        //键盘的样式
        keyboardType: TextInputType.number,
        //监听
        controller: controller,
        //最大长度
        // maxLength: 10,
        //颜色跟hintColor
        //最大行数
        maxLines: 1,
        //是否自动更正
        autocorrect: true,
        focusNode: bFocus,
        //是否自动化对焦
        autofocus: false,
        //是否是密码格式(输入的内容不可见)
        obscureText: false,
        //文本对齐方式
        textAlign: TextAlign.start,
        //输入文本的样式
        style: const TextStyle(fontSize: 14, color: Colors.black),
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
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            //有聚焦，labelText就会缩小到输入框左上角，颜色primaryColor，没聚焦前颜色跟hintColor
            // labelText: '帳號',
            //聚焦时才显示,颜色跟hintColor
            // hintText: '請輸入手機',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            // prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '心跳(次/分)',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            //输入框内右侧的widget
            // suffixIcon: const Icon(Icons.account_circle),
//            有聚焦显示颜色跟hintColor，显示在输入框的右边
//             suffixText: "后缀",
            isDense: true,
            contentPadding: const EdgeInsets.all(8),
            border: const OutlineInputBorder(
              // borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
              borderSide: BorderSide(
                  color: Colors.black,
                  width: 25.0), //边框颜色、大小没有效果，所以使用返回的是Theme，
            )),
      ),
    );
  }

  //呼吸
  static Widget buildMailTextField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: TextField(
        //键盘的样式
        keyboardType: TextInputType.number,
        //监听
        controller: controller,
        //最大长度
        // maxLength: 30,
        //颜色跟hintColor
        //最大行数
        maxLines: 1,
        //是否自动更正
        focusNode: cFocus,
        autocorrect: true,
        //是否自动化对焦
        autofocus: false,
        //是否是密码格式(输入的内容不可见)
        obscureText: false,
        //文本对齐方式
        textAlign: TextAlign.start,
        //输入文本的样式
        style: const TextStyle(fontSize: 14, color: Colors.black),
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
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            //有聚焦，labelText就会缩小到输入框左上角，颜色primaryColor，没聚焦前颜色跟hintColor
            // labelText: '帳號',
            //聚焦时才显示,颜色跟hintColor
            // hintText: '請輸入電子信箱',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            // prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '呼吸(次/分)',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.all(8),
            border: const OutlineInputBorder(
              // borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
              borderSide: BorderSide(
                  color: Colors.black,
                  width: 25.0), //边框颜色、大小没有效果，所以使用返回的是Theme，
            )),
      ),
    );
  }

  //收縮壓(mmHg)
  static Widget buildPasswordTextField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: TextField(
        obscureText: false,
        //键盘的样式
        keyboardType: TextInputType.number,
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
        focusNode: dFocus,
        autofocus: false,
        //是否是密码格式(输入的内容不可见)
        // obscureText: false,
        //文本对齐方式
        textAlign: TextAlign.start,
        //输入文本的样式
        style: const TextStyle(fontSize: 14, color: Colors.black),
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
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            //有聚焦，labelText就会缩小到输入框左上角，颜色primaryColor，没聚焦前颜色跟hintColor
            // labelText: '帳號',
            //聚焦时才显示,颜色跟hintColor
            // hintText: '至少8個字及一個大寫字母,小寫字母,數字',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            // prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '收縮壓(mmHg)',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            //输入框内右侧的widget
            // suffixIcon: const Icon(Icons.account_circle),
//            有聚焦显示颜色跟hintColor，显示在输入框的右边
//             suffixText: "后缀",
            isDense: true,
            contentPadding: const EdgeInsets.all(8),
            border: const OutlineInputBorder(
              // borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
              borderSide: BorderSide(
                  color: Colors.black,
                  width: 25.0), //边框颜色、大小没有效果，所以使用返回的是Theme，
            )),
      ),
    );
  }

  //舒張壓(mmHg)
  static Widget buildConfirmPasswordTextField(
      TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: TextField(
        obscureText: false,
        //键盘的样式
        keyboardType: TextInputType.number,
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
        focusNode: eFocus,
        autofocus: false,
        //是否是密码格式(输入的内容不可见)
        // obscureText: false,
        //文本对齐方式
        textAlign: TextAlign.start,
        //输入文本的样式
        style: const TextStyle(fontSize: 14, color: Colors.black),
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
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            //有聚焦，labelText就会缩小到输入框左上角，颜色primaryColor，没聚焦前颜色跟hintColor
            // labelText: '帳號',
            //聚焦时才显示,颜色跟hintColor
            // hintText: '請輸入確認密碼',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            // prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '舒張壓(mmHg)',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            //输入框内右侧的widget
            // suffixIcon: const Icon(Icons.account_circle),
//            有聚焦显示颜色跟hintColor，显示在输入框的右边
//             suffixText: "后缀",
            isDense: true,
            contentPadding: const EdgeInsets.all(8),
            border: const OutlineInputBorder(
              // borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
              borderSide: BorderSide(
                  color: Colors.black,
                  width: 25.0), //边框颜色、大小没有效果，所以使用返回的是Theme，
            )),
      ),
    );
  }

  static Widget buildSpO2TextField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: TextField(
        obscureText: false,
        //键盘的样式
        keyboardType: TextInputType.number,
        //监听
        controller: controller,
        //最大长度
        // maxLength: 30,
        //颜色跟hintColor
        //最大行数
        maxLines: 1,
        //是否自动更正
        focusNode: fFocus,
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
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            //有聚焦，labelText就会缩小到输入框左上角，颜色primaryColor，没聚焦前颜色跟hintColor
            // labelText: '帳號',
            //聚焦时才显示,颜色跟hintColor
            // hintText: '請輸入確認密碼',
            //红色
//            errorText: '输入错误',
            //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
            //输入框内左侧，有聚焦，颜色跟primaryColor
            // prefixIcon: const Icon(Icons.person),
            //输入框左侧的widget（可是text、icon……）
            icon: const Text(
              '血氧(%)',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            //输入框内右侧的widget
            // suffixIcon: const Icon(Icons.account_circle),
//            有聚焦显示颜色跟hintColor，显示在输入框的右边
//             suffixText: "后缀",
            isDense: true,
            contentPadding: const EdgeInsets.all(8),
            border: const OutlineInputBorder(
              // borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
              borderSide: BorderSide(
                  color: Colors.black,
                  width: 25.0), //边框颜色、大小没有效果，所以使用返回的是Theme，
            )),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 0),
      child: Column(
        //主轴Flex的值
        mainAxisSize: MainAxisSize.max,
        //MainAxisAlignment：主轴方向上的对齐方式，会对child的位置起作用
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildNameTextField(_accountController),
          Container(
            // margin: const EdgeInsets.fromLTRB(0, 0, 100, 0),
            child: const Text(
              '(正常範圍介於35.0~39.1)',
              style:
              TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1.0)
                  , fontSize: 14
              ),
            ),
          ),
          buildPhoneTextField(_phoneController),
          Container(
            // margin: const EdgeInsets.fromLTRB(0, 0, 100, 0),
            child: const Text(
              '(正常範圍介於40~131)',
              style:
              TextStyle(color: Color.fromRGBO(0, 0, 0, 1.0), fontSize: 14),
            ),
          ),
          buildMailTextField(_mailController),
          Container(
            // margin: const EdgeInsets.fromLTRB(0, 0, 100, 0),
            child: const Text(
              '(正常範圍介於8~25)',
              style:
              TextStyle(color: Color.fromRGBO(0, 0, 0, 1.0), fontSize: 14),
            ),
          ),
          buildPasswordTextField(_passwordController),
          Container(
            // margin: const EdgeInsets.fromLTRB(0, 0, 100, 0),
            child: const Text(
              '(正常範圍介於90~220)',
              style:
              TextStyle(color: Color.fromRGBO(0, 0, 0, 1.0), fontSize: 14),
            ),
          ),
          buildConfirmPasswordTextField(_confirmpasswordController),
          Container(
            // margin: const EdgeInsets.fromLTRB(0, 0, 100, 0),
            child: const Text(
              '(正常範圍介於50~120)',
              style:
              TextStyle(color: Color.fromRGBO(0, 0, 0, 1.0), fontSize: 14),
            ),
          ),
          buildSpO2TextField(_spo2Controller),
          Container(
            // margin: const EdgeInsets.fromLTRB(0, 0, 100, 0),
            child: const Text(
              '(正常範圍介於88~101)',
              style:
              TextStyle(color: Color.fromRGBO(0, 0, 0, 1.0), fontSize: 14),
            ),
          ),
          Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      // side: BorderSide(color: Colors.red)
                    ),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      backgroundColor: const Color.fromRGBO(195, 123, 222, 1.0),
                      foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
                      elevation: 0,
                      //minimumSize: Size(MediaQuery.of(context).size.width - 20, 40)
                  ),
                  child: const Icon(Icons.add_a_photo),
                )

                ,const SizedBox(height: 16,width: 10,)
                ,SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: _imageFile == null ? const Text('請上傳心電圖片') : Image.file(_imageFile!,fit: BoxFit.cover,),
                ),
                // ElevatedButton(
                //   // onPressed: _uploadImage,
                //   onPressed:() async{
                //     if (_imageFile == null) {
                //       _dialogBuilder( context,"無上傳照片");
                //       return;
                //     }
                //     final request = http.MultipartRequest(
                //       'POST',
                //       Uri.parse('http://211.20.21.35:8080/fjuheart/MH200101/insertattach'),
                //     );
                //     request.files.add(await http.MultipartFile.fromPath(
                //       'file',
                //       _imageFile!.path,
                //     ));
                //     request.fields["PARENT_SYS_ID"] = "";
                //     request.fields["VENDOR_ID"] = "";
                //     request.fields["MEMO"] = "";
                //
                //     final response = await request.send();
                //     if (response.statusCode == 200) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(content: Text('Upload success!')),
                //       );
                //     } else {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(content: Text('Upload failed!')),
                //       );
                //     }
                //   },
                //
                //   // tooltip: 'Upload Image',
                //   child: const Icon(Icons.file_upload),
                // ),

              ],
            )
          ]
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        // body: Center(
        //   child: _imageFile == null
        //       ? const Text('No image selected.')
        //       : Image.file(_imageFile!),
        // ),
        // floatingActionButton: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     ElevatedButton(
        //       onPressed: _pickImage,
        //       // tooltip: 'Pick Image',
        //       child: const Icon(Icons.add_a_photo),
        //     ),
        //     const SizedBox(height: 16),
        //     ElevatedButton(
        //       // onPressed: _uploadImage,
        //       onPressed:() async{
        //         if (_imageFile == null) {
        //           _dialogBuilder( context,"無上傳照片");
        //           return;
        //         }
        //         final request = http.MultipartRequest(
        //           'POST',
        //           Uri.parse('http://211.20.21.35:8080/fjuheart/MH200101/insertattach'),
        //         );
        //         request.files.add(await http.MultipartFile.fromPath(
        //           'file',
        //           _imageFile!.path,
        //         ));
        //         request.fields["PARENT_SYS_ID"] = "";
        //         request.fields["VENDOR_ID"] = "";
        //         request.fields["MEMO"] = "";
        //
        //         final response = await request.send();
        //         if (response.statusCode == 200) {
        //           ScaffoldMessenger.of(context).showSnackBar(
        //             const SnackBar(content: Text('Upload success!')),
        //           );
        //         } else {
        //           ScaffoldMessenger.of(context).showSnackBar(
        //             const SnackBar(content: Text('Upload failed!')),
        //           );
        //         }
        //       },
        //
        //       // tooltip: 'Upload Image',
        //       child: const Icon(Icons.file_upload),
        //     ),
        //   ],
        // ),
      )

          // const ImagePickerScreen()

        ],
      ),
    );
  }
}
Future resp() async {
  String flag = "";

  var DATA = [];

  List<Login>? result = await DatabaseHelper.getAllNotes();
  String? s=result?[0].account;

  DateTime dateTime = DateTime.now(); // 2021-07-25 14:01:14.127700
  String timeUnix = dateTime.millisecondsSinceEpoch.toString(); // 1627192874127


  DATA.add({
    "MEMBER_ID": s
    , "TRANSACTION_SEQ": timeUnix
    , "MEASURE_CODE": "M00001"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": double.parse(_accountController.text)
    , "UPDATE_BY": s
  });

  DATA.add({
    "MEMBER_ID": s
    , "TRANSACTION_SEQ": timeUnix
    , "MEASURE_CODE": "M00002"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": int.parse(_phoneController.text)
    , "UPDATE_BY": s
  });

  DATA.add({
    "MEMBER_ID": s
    , "TRANSACTION_SEQ": timeUnix
    , "MEASURE_CODE": "M00003"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": int.parse(_mailController.text)
    , "UPDATE_BY": s
  });

  DATA.add({
    "MEMBER_ID": s
    , "TRANSACTION_SEQ": timeUnix
    , "MEASURE_CODE": "M00004"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": int.parse(_passwordController.text)
    , "UPDATE_BY": s
  });

  DATA.add({
    "MEMBER_ID": s
    , "TRANSACTION_SEQ": timeUnix
    , "MEASURE_CODE": "M00005"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": int.parse(_confirmpasswordController.text)
    , "UPDATE_BY": "doctor"
  });

  DATA.add({
    "MEMBER_ID": s
    , "TRANSACTION_SEQ": timeUnix
    , "MEASURE_CODE": "M00006"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": int.parse(_spo2Controller.text)
    , "UPDATE_BY": s
  });
  DATA.add({
    "MEMBER_ID": s
    , "TRANSACTION_SEQ": timeUnix
    , "MEASURE_CODE": "M00007"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 0
    , "UPDATE_BY": s
  });
  DATA.add({
    "MEMBER_ID": s
    , "TRANSACTION_SEQ": timeUnix
    , "MEASURE_CODE": "M00008"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 0
    , "UPDATE_BY": s
  });
  DATA.add({
    "MEMBER_ID": s
    , "TRANSACTION_SEQ": timeUnix
    , "MEASURE_CODE": "M00009"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 0
    , "UPDATE_BY": s
  });
  var data = {"DATA": DATA};
  final String jsonString = jsonEncode(data);
  // print(jsonString);
  final response = await http.post(
    Uri.parse('http://211.20.21.35:8080/fjuheart/MH200101/insert'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Access-Control-Allow-Origin': '*',
    },
    body: jsonString
    // body: jsonEncode(<String, String>{
    //   // "EMAIL": EMAIL
    //   // , "USER_PASSWORD_ENC": userPasswordEnc
    //   // , "USER_NAME": userName
    //   // , "TELEPHONE": PHONE
    //   // EMAIL: $("#EMAIL").val()
    //   // , USER_PASSWORD_ENC: $("#USER_PASSWORD_ENC").val()
    //   // , USER_NAME: $("#USER_NAME").val()
    //   // , TELEPHONE: $("#TELEPHONE").val()
    // }),
  );

  if (response.statusCode == 200) {
    if (jsonDecode(response.body)["RETURNVALUE"] == "Y") {
      // flag = "Y";

      final request1 = http.MultipartRequest(
        'POST',
        Uri.parse('http://211.20.21.35:8080/fjuheart/MH200101/insertattach'),
      );
      request1.files.add(await http.MultipartFile.fromPath(
        'file',
        _imageFile!.path,
      ));
      request1.fields["PARENT_SYS_ID"] = s!;
      request1.fields["VENDOR_ID"] = timeUnix;
      request1.fields["MEMO"] = "";

      final response1 = await http.Response.fromStream(await request1.send());
      if (response1.statusCode == 200) {
        if (jsonDecode(response1.body)["RETURNVALUE"] == "Y") {
          flag = "Y";
        }else{
          flag = jsonDecode(response.body)["RETURNMSG"];
        }

        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Upload success!')),
        // );
      } else {
        flag = "文件傳輸失敗";
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Upload failed!')),
        // );
      }




    } else {
      flag = jsonDecode(response.body)["RETURNMSG"];
    }
  } else {
    flag = "連線失敗";
  }

  return flag;
}
Future<void> _dialogBuilder(BuildContext context, String checkHint, String state) {
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
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(); //弹窗消失
                switch (state) {
                  case "A":
                    aFocus.requestFocus();
                    break;
                  case "B":
                    bFocus.requestFocus();
                    break;
                  case "C":
                    cFocus.requestFocus();
                    break;
                  case "D":
                    dFocus.requestFocus();
                    break;
                  case "E":
                    eFocus.requestFocus();
                    break;
                  case "F":
                    fFocus.requestFocus();
                    break;
                  case "X":
                    // fFocus.requestFocus();
                    break;
                  default:
                    break;
                }
              },
              child: const Text('確定')),
        ],
      );
    },
  );
}
Future<void> _dialogBuilder2(BuildContext context, String checkHint) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '提示',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        content: Text(checkHint),
        actions: <Widget>[
          TextButton(//一个扁平的Material按钮
              onPressed: () {
                Navigator.of(context).pop();//弹窗消失
                buffer.clear();
              },
              child: const Text('取消')),
          TextButton(
              onPressed: () async {
                //送出
                var f = await resp();
                if (f == "Y") {
                  _dialogBuilder1(context, "新增完成");
                } else {
                  _dialogBuilder(context, f,"");
                }
                buffer.clear();
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
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        content: Text(checkHint),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return  JsonDataGrid(Measure_s: '', Measure_e: '');
                    }));
              },
              child: const Text('確定')),
        ],
      );
    },
  );
}
