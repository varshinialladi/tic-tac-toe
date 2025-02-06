import 'package:flutter/material.dart';
import 'screens/MyWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tic tac toe',
      color: const Color.fromARGB(255, 222, 40, 143),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
      ),
      home: new MyWidget(),
    );
  }
}
