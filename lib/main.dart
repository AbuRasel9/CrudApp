import 'package:crud_app/Screens/AllProductScreen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AllProductScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
