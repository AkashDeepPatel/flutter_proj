import 'package:flutter/material.dart';
import 'package:flutter_proj/ticker_list_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tickers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TickerListPage(),
    );
  }
}
