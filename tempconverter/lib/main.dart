import 'package:flutter/material.dart';
import 'temp_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temp Converter',
      // theme: ThemeData( // this is used to change the default color of elevated button
      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ButtonStyle(
      //       backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 134, 134, 134)),
      //     ),
      //   ),
      // ),
      home: TempPage(),
    );
  }
}

