import 'package:flutter/material.dart';
import 'package:project_chat/pages/auth.page.dart';
import 'package:project_chat/pages/loading.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
