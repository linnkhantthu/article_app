import 'package:article_app/user/RegisterPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Article',
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      home: RegisterPage(),
    );
  }
}
