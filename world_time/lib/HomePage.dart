// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map? data = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = data!.isNotEmpty ?data : ModalRoute.of(context)?.settings.arguments as Map?;
    // print(data);

    //set background
    String bgImage = data!['isDayTime'] ? 'day.png' : 'night.png';
    // Color? stripColor = data!['isDayTime'] ? Colors.blue:Colors.indigo[700];//for the strip color at the top, which will be according to day and night
    Color stripColor = const Color.fromRGBO(26, 35, 126, 1);

    return Scaffold(
      backgroundColor: stripColor,
      body: SafeArea(
          // safe area is use so that the design won't come in the area of notfication bar, when we are not using appbar
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/$bgImage'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
          child: Column(
            children: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(
                      // here we provide a another page name, which is there in the route of the main page,esentially what we do we push one screen to another screen and the previous screen is going to be the there just bellow the opened screen,
                      // likewise it store the screen in stack and pusing the button back it pop out that particular ecreen back
                      context,
                      "/location");

                  setState(() {
                    data = {
                      'time' : result['time'],
                      'location' : result['location'],
                      'isDayTime' : result['isDayTime'],
                      'flag':result['flag']
                    };
                  });
                },
                icon: const Icon(
                  Icons.edit_location,
                  color: Color.fromRGBO(224, 224, 224, 1),
                ),
                label: const Text(
                  "Edit Location",
                  style: TextStyle(
                    color: Color.fromRGBO(224, 224, 224, 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data!['location'],
                    style: const TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                data!['time'],
                style: const TextStyle(
                  fontSize: 66.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
