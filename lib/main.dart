import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_tracker/provider/date_provider.dart';
import 'package:sleep_tracker/screens/start.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DateProvider>(
      create: (context) => DateProvider(),
      child: MaterialApp(
        home: StartScreen(),
      ),
    );
  }
}
