import 'package:darchat/chat/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:darchat/injection.dart' as di;

import 'core/consts/consts.dart';
import 'package:darchat/router.dart' as app_route;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'پشتیبانی',
      onGenerateRoute: app_route.Router.generateRoute,
      home: const HomeScreen(),
      initialRoute: app_route.home,
      theme: ThemeData(
          fontFamily: 'Dana',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xfff7f7f7),
            elevation: 0,
          )),
    );
  }
}
