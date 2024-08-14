import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_magang_test/models/state.dart';
import 'package:suitmedia_magang_test/screen/screen.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (contex) => StateApp(), child:  MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/first_screen',
      routes: {
        '/first_screen': (context) => FirstScreen(),
        '/second_screen': (context) => SecondScreen(),
        '/third_screen': (context) => ThirdScreen()
      },
    );
  }
}

