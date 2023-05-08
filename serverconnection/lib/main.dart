// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:serverconnection/AllItems.dart';
import 'MongoDBConnection.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // _HomePageState() {
  //   _getData();
  // }

  final _pid = TextEditingController();
  final _pName = TextEditingController();
  final _pPrice = TextEditingController();

  void _fakeData() {
    _pid.text = "${faker.randomGenerator.integer(1000)}";
    _pName.text = faker.food.dish();
    _pPrice.text = "${faker.randomGenerator.decimal() * 100}";
    // _pImagePath.text = "https\\${_pName.text}";
  }

  void clearAll() {
    _pid.text = "";
    _pName.text = "";
    _pPrice.text = "";
  }

  Future<void> _insertData() async {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Inserting Data To Database....")));
    WidgetsFlutterBinding.ensureInitialized();
    String a = _pid.text;
    String b = _pName.text;
    String c = _pPrice.text;
    clearAll();
    await MongoDBConnection.insert(a, b, c);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Data Inserted!")));
  }

  List<Map<String, Object?>> data = [];
  Future<void> _getData() async {
    WidgetsFlutterBinding.ensureInitialized();
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fetching Data From Database....")));
    data = await MongoDBConnection.getData();
    // Data = data;
    // print(Data);
  }

  @override
  Widget build(BuildContext context) {
    // _getData();
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        elevation: 10,
        title: const Text("Connection To MongoDB"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Insert Data",
                style: TextStyle(fontSize: 22.0),
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextField(
                // enabled: false,
                controller: _pName,
                cursorColor: Colors.green[600],
                cursorWidth: 2.0,
                decoration: InputDecoration(
                  hintText: "PRODUCT NAME",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(27, 94, 32, 1))),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color.fromRGBO(27, 94, 32, 1)),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextField(
                controller: _pPrice,
                cursorColor: Colors.green[600],
                cursorWidth: 2.0,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "PRODUCT PRICE",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(27, 94, 32, 1))),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color.fromRGBO(27, 94, 32, 1)),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                maxLength: 25,
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextField(
                controller: _pid,
                cursorColor: Colors.green[600],
                cursorWidth: 2.0,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "PRODUCT ID",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(27, 94, 32, 1))),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color.fromRGBO(27, 94, 32, 1)),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                maxLength: 25,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _fakeData();
                        });
                      },
                      child: const Text(
                        "Generate Data",
                        style: TextStyle(
                          color: Color.fromRGBO(67, 160, 71, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_pid.text != "" &&
                            _pName.text != "" &&
                            _pPrice.text != "") {
                          setState(() {
                            _insertData();
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Please Fill The Requird Blocks To Insert Data In The Database!")));
                        }
                        // _getData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        elevation: 10,
                      ),
                      child: const Text("Insert Data"),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async{
                        await _getData();
                        // print(Data);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AllItems(allItemList: data)));

                        clearAll();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        elevation: 10,
                      ),
                      child: const Text("All items"),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    // OutlinedButton(
                    //   onPressed: () {},
                    //   child: const Text(
                    //     "Delete Data",
                    //     style: TextStyle(color: Color.fromRGBO(67, 160, 71, 1)),
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// to build the apk file which you can shre to anyone
//flutter build apk --build-name=1.2.3 --build-number=99