// 管理路由
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/index.dart';
import 'package:hm_shop/pages/Main/index.dart';

Widget getRootWidget() {
  return MaterialApp(initialRoute: '/', routes: getRootRoutes());
}

Map<String, Widget Function(BuildContext context)> getRootRoutes() {
  return {'/': (context) => MainPage(), '/login': (context) => LoginPage()};
}
