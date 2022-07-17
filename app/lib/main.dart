import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qute Quotes',
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Qute Quotes'),
          ),
          body: const FailedConnectionWidget(),
        );
      },
    );
  }
}
