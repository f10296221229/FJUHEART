import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/ChartData.dart';
import '../screen/ChartDataGrid.dart';
import '../service/PostProvider.dart';

class TextSectionDate extends StatefulWidget {
  const TextSectionDate({super.key, required this.Ms,required this.Me,required this.type,required this.typeName});
  final String Ms;
  final String Me;
  final String type;
  final String typeName;

  @override
  State<TextSectionDate> createState() => _TextSectionDate(Ms: Ms, Me: Me, type: type, typeName: typeName);
}

class _TextSectionDate extends State<TextSectionDate> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = TextEditingController();
  TextEditingController _date_e = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  _TextSectionDate({required this.Ms,required this.Me,required this.type,required this.typeName});
  final String Ms;
  final String Me;
  final String type;
  final String typeName;


  @override
  void initState() {

    String d =
        "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().day < 10 ? "0${DateTime.now().day}" : DateTime.now().day}";

    String t =

        "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-01";

    // "${DateTime.now().subtract(const Duration(days: 180)).year}-${DateTime.now().subtract(const Duration(days: 180)).month < 10 ? "0${DateTime.now().subtract(const Duration(days: 180)).month}" : DateTime.now().subtract(const Duration(days: 180)).month}-${DateTime.now().subtract(const Duration(days: 180)).day < 10 ? "0${DateTime.now().subtract(const Duration(days: 180)).day}" : DateTime.now().subtract(const Duration(days: 180)).day}";
        // "${DateTime.now().subtract(const Duration(days: 180)).year}-${DateTime.now().subtract(const Duration(days: 180)).month < 10 ? "0${DateTime.now().subtract(const Duration(days: 180)).month}" : DateTime.now().subtract(const Duration(days: 180)).month}-${DateTime.now().subtract(const Duration(days: 180)).day < 10 ? "0${DateTime.now().subtract(const Duration(days: 180)).day}" : DateTime.now().subtract(const Duration(days: 180)).day}";

    // MEASURE_DT_S = (Ms == "" ? t : Ms);
    // MEASURE_DT_E = (Me == "" ? d : Me);

    // TYPE=type;
    // TYPENAME=typeName;


    _date = TextEditingController(text: Ms == "" ? t : Ms);
    _date_e = TextEditingController(text: Me == "" ? d : Me);
    super.initState();
  }

  void _navigateAndDisplaySelection1(BuildContext context,DateTime account)  {
    String MEASURE_DT_S = "${account?.year}-${account!.month < 10 ? "0${account.month}" : account.month}-${account.day < 10 ? "0${account.day}" : account.day}";
    if(type=="M00004"){
      context.read<PostProvider>().fetchData1(_date.text,MEASURE_DT_S,type);
    }else{
      context.read<PostProvider>().fetchData(_date.text,MEASURE_DT_S,type);
    }
  }

  void _navigateAndDisplaySelection(BuildContext context,DateTime account)  {

    String MEASURE_DT_S = "${account?.year}-${account!.month < 10 ? "0${account.month}" : account.month}-${account.day < 10 ? "0${account.day}" : account.day}";
    if(type=="M00004"){
      context.read<PostProvider>().fetchData1(MEASURE_DT_S,_date_e.text,type);
    }else{
      context.read<PostProvider>().fetchData(MEASURE_DT_S,_date_e.text,type);
    }
  }

  //姓名
  Widget buildNameTextField(TextEditingController controller) {

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: DateTimeField(
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
              // locale: const Locale("fr"),
              // builder: (context, child) => Localizations.override(
              //   context: context,
              //   locale: const Locale('zh'),
              //   child: child,
              // ),
            );
          },
          //键盘的样式
          keyboardType: TextInputType.datetime,
          //监听
          controller: _date,
          //最大长度
          // maxLength: 30,
          //颜色跟hintColor
          //最大行数
          maxLines: 1,
          //是否自动更正
          autocorrect: false,
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

            _navigateAndDisplaySelection(context,account!);
            // setState(() {
            //   String MEASURE_DT_S = "${account?.year}-${account!.month < 10 ? "0${account.month}" : account.month}-${account.day < 10 ? "0${account.day}" : account.day}";
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (BuildContext context) {
            //         return  ChartDataGrid(Ms: MEASURE_DT_S, Me: Me, type: type, typeName: typeName,);
            //       }));
            // });

          },
          // onChanged: (account) {
          //   BuilderState builder =  BuilderState();
          //   builder.refreshList();
          // },
          // onTap: ()  {
          //   FocusScope.of(context).requestFocus(FocusNode());
          //   _selectDate(context);
          //   print('change');
          // },
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
                '開始：',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(8),
              //输入框内右侧的widget
              // suffixIcon: const Icon(Icons.account_circle),
//            有聚焦显示颜色跟hintColor，显示在输入框的右边
//             suffixText: "后缀",
//               contentPadding: const EdgeInsets.all(5),
              border: const OutlineInputBorder(
                // borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
                borderSide: BorderSide(
                    color: Colors.black,
                    width: 25.0), //边框颜色、大小没有效果，所以使用返回的是Theme，
              ))),
    );
  }

  Widget buildNameTextField1(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: DateTimeField(
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
              // locale: const Locale("zh"),
              // builder: (context, child) => Localizations.override(
              //   context: context,
              //   locale: const Locale('zh'),
              //   child: child,
              // ),
            );
          },
          //键盘的样式
          keyboardType: TextInputType.datetime,
          //监听
          controller: _date_e,
          //最大长度
          // maxLength: 30,
          //颜色跟hintColor
          //最大行数
          maxLines: 1,
          //是否自动更正
          autocorrect: false,
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

            _navigateAndDisplaySelection1(context,account!);
            // setState(() {
            //   String MEASURE_DT_E = "${account?.year}-${account!.month < 10 ? "0${account.month}" : account.month}-${account.day < 10 ? "0${account.day}" : account.day}";
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (BuildContext context) {
            //         return ChartDataGrid(Ms: Ms, Me: MEASURE_DT_E, type: type, typeName: typeName,);
            //       }));
            // });
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
              // hintText: '請輸入姓名',
              //红色
//            errorText: '输入错误',
              //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
              //输入框内左侧，有聚焦，颜色跟primaryColor
              // prefixIcon: const Icon(Icons.person),
              //输入框左侧的widget（可是text、icon……）
              icon: const Text(
                '結束：',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(8),
              //输入框内右侧的widget
              // suffixIcon: const Icon(Icons.account_circle),
//            有聚焦显示颜色跟hintColor，显示在输入框的右边
//             suffixText: "后缀",
//               contentPadding: const EdgeInsets.all(5),
              border: const OutlineInputBorder(
                // borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
                borderSide: BorderSide(
                    color: Colors.black,
                    width: 25.0), //边框颜色、大小没有效果，所以使用返回的是Theme，
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        //主轴Flex的值
        mainAxisSize: MainAxisSize.max,
        //MainAxisAlignment：主轴方向上的对齐方式，会对child的位置起作用
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildNameTextField(_date),
          buildNameTextField1(_date_e),
        ],
      ),
    );
  }
}