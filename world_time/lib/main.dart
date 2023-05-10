import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Loading.dart';
import 'ChooseLocation.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    initialRoute: "/", // overrides the first key value pair of routes

    routes: { //this property gonna a take map(key,value) => value shoud be the widget
    //here each key takes the function with context as argument which keep trakes where the widget is, in the whole scheme
    "/":(context) => const Loading(), // the first key value pair is the default treated as home screen, if you want any other as screen u can use initialRoute keyword as used above
    "/home" :(context) => const HomePage(),
    "/location":(context) => const ChooseLoaction(),
    },
  ));
}
