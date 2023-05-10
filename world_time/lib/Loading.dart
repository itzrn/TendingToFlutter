// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'WorldTime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // String time = "loading";
  void setUpWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Barlin', flag: 'germany.png', url: 'Europe/Berlin');
    await instance.getTime();
    // setState(() {
    //   time = instance.time;
    // });
    // Navigator.pushNamed(context, '/home'); // we actually pushed home page at the top of the Loading Page, but we dont want to keep that loading page at the background running, so instead using pushNamed() function we will use pushRepalcementNamed() function
    
    Navigator.pushReplacementNamed(context, '/home', 
      arguments: {// to send any perameter to the next widget we use here a third parameter that is argument  which takes the input as map
        'location':instance.location,
        'flag':instance.flag,
        'time':instance.time,
        'isDayTime':instance.isDayTime,
      }); // this will replace the loading page with home page which was the wastage when it was running behind

  }

  @override
  void initState() {
    // first initState function runs then build function runs
    // this fires once when we load the state or object of the widget
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCubeGrid( // we can changet he loading of the style
          color: Colors.indigo[900],
          size: 80.0,
        ),
      ),
    );
  }
}
