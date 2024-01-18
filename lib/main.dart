import 'package:devtest01/model/login_model.dart';
import 'package:devtest01/screen/ForgetScreen.dart';
import 'package:devtest01/screen/HomeScreen1.dart';
import 'package:devtest01/screen/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screen/Home.dart';
import '../screen/LoginScreen.dart';
import '../service/login_database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

String url="";
Future main() async {

  WidgetsFlutterBinding.ensureInitialized();  		//不加这个强制横/竖屏会报错
  SystemChrome.setPreferredOrientations([     // 强制竖屏
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  List<Login>? result = await DatabaseHelper.getAllNotes();
  if(result==null){
    url="/";


  }else{
    url="/Home";
    // print(result?[0].account);
    // print("NO");
  }
  // print('Query Result: $result');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AI示警登入',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch(url) {
          case '/':
            builder = (_) => const LoginScreen();
            break;
          case '/Home':
            builder = (_) => const Home();
            break;
          default:
            throw  Exception('路由名稱有誤: ${settings.name}');
        }
        return  MaterialPageRoute(builder: builder, settings: settings);
      },
        // initialRoute: url,
        // routes: {
        //   '/': (BuildContext context) => const LoginScreen(),
        //   '/FORGET': (BuildContext context) => const ForgetScreen(),
        //   '/Home': (BuildContext context) => const Home(),
        //   '/Register': (BuildContext context) => const RegisterScreen(),
        //   '/HomeScreen1': (BuildContext context) => const HomeScreen1(),
        // }
    );
  }
}




