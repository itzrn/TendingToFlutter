import 'package:flutter/material.dart';

class TempPage extends StatefulWidget {
  const TempPage({super.key});

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  final textController = TextEditingController();

  Color onTap1 = const Color.fromARGB(255, 134, 134, 134);
  Color onTap2 = const Color.fromARGB(255, 134, 134, 134);

  double toF(double c) {
    return (c * 9 / 5) + 32;
  }

  double toC(double f) {
    return (f - 32) * 5 / 9;
  }

  String result = "";

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      // here GesterDetector is used to hide the keyboard on taping anywhere on the screen
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          setState(() {
            onTap1 = const Color.fromARGB(255, 134, 134, 134);
            onTap2 = const Color.fromARGB(255, 134, 134, 134);
            result = "";
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Text("Temperature Converter"),
          elevation: 15.0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 125.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Enter Temperature :",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  SizedBox(
                      width: 150.0,
                      child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: "value",
                          contentPadding: EdgeInsets.only(top: 17.0),
                          enabledBorder: UnderlineInputBorder(
                            // this is used to change the color of baseline of TextField before tap on the text field
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            // this is used to change the color of baseline of TextField after tap on the text field
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        cursorColor: const Color.fromARGB(255, 0, 0, 0),
                        keyboardType: TextInputType.number,
                        cursorHeight: 25.0,
                        maxLength: 6,
                      ))
                ],
              ),
              const SizedBox(
                height: 125.0,
              ),
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 43.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        try {
                          double.parse(textController.text.toString());
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Please Enter The Valid Input!")));
                          return;
                        }
                        if (textController.text.toString() == "" ||
                            double.parse(textController.text.toString()) >
                                100.00 ||
                            double.parse(textController.text.toString()) <
                                0.00) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Please Enter The Valid/Required Input!")));
                          result = "";
                          
                          onTap1 = const Color.fromARGB(255, 134, 134, 134);
                          onTap2 = const Color.fromARGB(255, 134, 134, 134);
                          return;
                        }
                        onTap1 = Colors.black;
                        onTap2 = const Color.fromARGB(255, 134, 134, 134);
                        result =
                            "${toF(double.parse(textController.text.toString())).toStringAsFixed(2)}\u00B0F";
                        currentFocus.unfocus();
                      });
                    },
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(110, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(onTap1),
                    ),
                    child: const Text(
                      "\u00B0C to \u00B0F",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  const SizedBox(
                    width: 110.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        try {
                          double.parse(textController.text.toString());
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Please Enter The Valid Input!")));
                          return;
                        }
                        if (textController.text.toString() == "" ||
                            double.parse(textController.text.toString()) <
                                0.00 ||
                            double.parse(textController.text.toString()) >
                                212.00) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Please Enter The Valid/Required Input!")));
                          result = "";
                          
                          onTap1 = const Color.fromARGB(255, 134, 134, 134);
                          onTap2 = const Color.fromARGB(255, 134, 134, 134);
                          return;
                        }
                        onTap1 = const Color.fromARGB(255, 134, 134, 134);
                        onTap2 = Colors.black;
                        result =
                            "${toC(double.parse(textController.text.toString())).toStringAsFixed(2)}\u00B0C";
                        currentFocus.unfocus();
                      });
                    },
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(110, 50)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(onTap2)),
                    child: const Text(
                      "\u00B0F to \u00B0C",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 170.0,
              ),
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 60.0,
                  ),
                  const Text(
                    "Result --->",
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    result.toString(),
                    style: const TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
