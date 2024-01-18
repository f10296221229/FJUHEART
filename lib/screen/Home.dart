import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'MineScreen.dart';
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<StatefulWidget> createState() {
    return  _HomeState();
  }
}
class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
     const HomeScreen(),//首页界面
     // const MineScreen(),//我的界面
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: onTabTapped, //点击切换
      //   currentIndex: _currentIndex,
      //   items: const [
      //      BottomNavigationBarItem(
      //       icon:  Icon(Icons.home),
      //        label: '首頁',
      //     ),
      //      BottomNavigationBarItem(
      //       icon:  Icon(Icons.person),
      //        label:  '我的',
      //     ),
      //   ],
      // ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
