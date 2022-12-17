import 'package:flutter/material.dart';
import 'package:snake_game/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Scaffold(body: HomePage()),
    );
  }
}
