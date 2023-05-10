// ignore_for_file: file_names

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // lacation name for the UI
  late String time; // time in that location
  String flag; // url to an asset flah icon
  String url; // location url for api end point
  late bool isDayTime; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //making the request
      Response response = await get(
          Uri.parse('https://www.worldtimeapi.org/api/timezone/$url'));
      // print(response.body);
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from data
      String datetime = data['datetime'];
      String utcOffset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(utcOffset);

      //create Datatime Ogject
      DateTime now = DateTime.parse(
          datetime); // to get the current datetime we need to add the utcOffset
      now = now.add(Duration(hours: int.parse(utcOffset)));

      //setting the time property
      // time = now.toString();
      isDayTime = now.hour > 6 && now.hour < 20
          ? true
          : false; //using ternary operator --> condition?true:false;
      time = DateFormat.jm()
          .format(now); // this converting the time to human readable
    } catch (e) {
      // print(" caught error : $e");
      time = "Could not get time data";
    }
  }
}
