import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/My/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/home.png",
      "activeIcon": "lib/assets/home-act.png",
      "text": "首页",
    },
    {
      "icon": "lib/assets/type.png",
      "activeIcon": "lib/assets/type-act.png",
      "text": "分类",
    },
    {
      "icon": "lib/assets/cart.png",
      "activeIcon": "lib/assets/cart-active.png",
      "text": "购物车",
    },
    {
      "icon": "lib/assets/my.png",
      "activeIcon": "lib/assets/my-act.png",
      "text": "我的",
    },
  ];

  List<Widget> _getpageList() {
    return [HomeView(), CategoryView(), CartView(), MyView()];
  }

  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["activeIcon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getpageList()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _getTabBarWidget(),
      ),
    );
  }
}
