// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'WorldTime.dart';

class ChooseLoaction extends StatefulWidget {
  const ChooseLoaction({super.key});

  @override
  State<ChooseLoaction> createState() => _ChooseLoactionState();
}

class _ChooseLoactionState extends State<ChooseLoaction> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  // int counter = 0;

  void upDateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    // naviagting to home screen
    Navigator.pop(context, {
        'location':instance.location,
        'flag':instance.flag,
        'time':instance.time,
        'isDayTime':instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    // this fires every time when we load up the widget tree
    // print('build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: const Text("Choose A Location"),
        centerTitle: true,
        elevation: 20,
      ),

      // body: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //         backgroundColor: Colors.indigo[900],
      //         minimumSize: const Size(150, 60),
      //         elevation: 25,
      //         shadowColor: Colors.indigo[200],
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(20)),
      //         side: const BorderSide(
      //           color: Colors.black,
      //           width: 3,
      //         )),
      //     onPressed: () {
      //       setState(() {
      //         counter += 1;
      //       });
      //     },
      //     child: Text('counter is $counter'),
      //   ),
      // ),

      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    // print(locations[index].location);
                    upDateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
                elevation: 10.0,
              ),
            );
          }),
    );
  }
}

/**
 * Stateless ->
 * State does not change over time
 * build function only runs once
 * 
 * Stateful ->
 * State can change over time
 * setState() triggers the build function
 * initState()
 * called only once when the widget is created
 * subscribe to streams or any object that could change our widget data
 * build()
 * builds the widget tree
 * a build is triggered every time we use setState()
 * Dispose()
 * when the widget/state object is removed
 */

/**
 * Padding means the boarder outside the widget(any)
 */