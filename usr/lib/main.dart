import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CloneAppPro());
}

class CloneAppPro extends StatelessWidget {
  const CloneAppPro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clone App Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
