// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'MongoDBConnection.dart';

class ItemCard extends StatefulWidget {
  final Map<String, Object?> itemDetails;
  final Function delete;
  const ItemCard({super.key, required this.itemDetails, required this.delete});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  final _pid = TextEditingController();
  final _pName = TextEditingController();
  final _pPrice = TextEditingController();

  // void test(){
  //   _pid.text = widget.itemDetails[""].toString();
  // }

  void clearAll() {
    _pid.text = "";
    _pName.text = "";
    _pPrice.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.black,
      margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Product Name ---> ${widget.itemDetails["Product Name"]}",
              style: TextStyle(color: Colors.green[600]),
            ),
            Text(
              "Product ID ---> ${widget.itemDetails["Product ID"]}",
              style: TextStyle(color: Colors.green[600]),
            ),
            Text(
              "Product Price ---> ${widget.itemDetails["Product price"]}",
              style: TextStyle(color: Colors.green[600]),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    widget.delete();
                    MongoDBConnection.deleteOne(widget.itemDetails["_id"]);
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.red[50])),
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text(
                    "remove",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.green[10],
                        title: const Text("Do you really want to update?"),
                        content: SingleChildScrollView(
                          physics:
                              const BouncingScrollPhysics(), // by using this that glow color went off which was comming at the end or start of the scrolling
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextField(
                                controller: _pName,
                                cursorColor: Colors.green[600],
                                cursorWidth: 2.0,
                                decoration: InputDecoration(
                                    hintText: "PRODUCT NAME",
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: const BorderSide(
                                            color:
                                                Color.fromRGBO(27, 94, 32, 1))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(27, 94, 32, 1)),
                                      borderRadius: BorderRadius.circular(30.0),
                                    )),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextField(
                                controller: _pPrice,
                                cursorColor: Colors.green[600],
                                keyboardType: TextInputType.number,
                                cursorWidth: 2.0,
                                decoration: InputDecoration(
                                  hintText: "PRODUCT PRICE",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(27, 94, 32, 1))),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(27, 94, 32, 1)),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                maxLength: 25,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TextField(
                                controller: _pid,
                                cursorColor: Colors.green[600],
                                keyboardType: TextInputType.number,
                                cursorWidth: 2.0,
                                decoration: InputDecoration(
                                  hintText: "PRODUCT ID",
                                  // enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(27, 94, 32, 1)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(27, 94, 32, 1)),
                                  ),
                                ),
                                maxLength: 25,
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              setState(() {
                                if (_pid.text == "" &&
                                    _pName.text == "" &&
                                    _pPrice.text == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Please Fill Anyone Of The Requird Blocks To Update The Database!")));
                                  return;
                                } else if (_pName.text != "" &&
                                    _pid.text != "" &&
                                    _pPrice.text != "") {
                                  MongoDBConnection.updateOne(
                                      widget.itemDetails["_id"],
                                      pId: _pid.text,
                                      pName: _pName.text,
                                      pPrice: _pPrice.text);
                                  widget.itemDetails["Product Name"] =
                                      _pName.text;
                                  widget.itemDetails["Product ID"] = _pid.text;
                                  widget.itemDetails["Product price"] =
                                      _pPrice.text;
                                } else {
                                  if (_pName.text == "" && _pPrice.text == "") {
                                    MongoDBConnection.updateOne(
                                        widget.itemDetails["_id"],
                                        pId: _pid.text,
                                        pName: null,
                                        pPrice: null);
                                    widget.itemDetails["Product ID"] =
                                        _pid.text;
                                  } else if (_pName.text == "" &&
                                      _pid.text == "") {
                                    MongoDBConnection.updateOne(
                                        widget.itemDetails["_id"],
                                        pPrice: _pPrice.text,
                                        pName: null,
                                        pId: null);
                                    widget.itemDetails["Product price"] =
                                        _pPrice.text;
                                  } else if (_pPrice.text == "" &&
                                      _pid.text == "") {
                                    MongoDBConnection.updateOne(
                                        widget.itemDetails["_id"],
                                        pName: _pName.text,
                                        pId: null,
                                        pPrice: null);
                                    widget.itemDetails["Product Name"] =
                                        _pName.text;
                                  } else if (_pName.text == "") {
                                    MongoDBConnection.updateOne(
                                        widget.itemDetails["_id"],
                                        pId: _pid.text,
                                        pPrice: _pPrice.text,
                                        pName: null);
                                    widget.itemDetails["Product price"] =
                                        _pPrice.text;
                                    widget.itemDetails["Product ID"] =
                                        _pid.text;
                                  } else if (_pPrice.text == "") {
                                    MongoDBConnection.updateOne(
                                        widget.itemDetails["_id"],
                                        pId: _pid.text,
                                        pName: _pName.text,
                                        pPrice: null);
                                    widget.itemDetails["Product ID"] =
                                        _pid.text;
                                    widget.itemDetails["Product Name"] =
                                        _pName.text;
                                  } else {
                                    MongoDBConnection.updateOne(
                                        widget.itemDetails["_id"],
                                        pName: _pName.text,
                                        pPrice: _pPrice.text,
                                        pId: null);
                                    widget.itemDetails["Product Name"] =
                                        _pName.text;
                                    widget.itemDetails["Product price"] =
                                        _pPrice.text;
                                  }
                                  ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Database Updated!")));
                                }
                                clearAll();
                                Navigator.pop(context);
                              });
                            },
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.green[50])),
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                color: Color.fromRGBO(27, 94, 32, 1),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.green[50]),
                            ),
                            child: const Text(
                              "No",
                              style: TextStyle(
                                color: Color.fromRGBO(27, 94, 32, 1),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.orange[50])),
                  icon: const Icon(
                    Icons.update,
                    color: Colors.orange,
                  ),
                  label: const Text(
                    "update",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class ItemCard extends StatelessWidget {
//   final Map<String, Object?> itemDetails;
//   final Function delete;
//   const ItemCard({super.key, required this.itemDetails, required this.delete});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       // color: Colors.black,
//       margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Text("Product Name ---> ${itemDetails["Product Name"]}",
//             style: TextStyle(color: Colors.green[600]),),
//             Text("Product ID ---> ${itemDetails["Product ID"]}",
//             style: TextStyle(color: Colors.green[600]),),
//             Text("Product Price ---> ${itemDetails["Product price"]}",
//             style: TextStyle(color: Colors.green[600]),),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 TextButton.icon(
//                   onPressed: () async{
//                     delete();
//                     MongoDBConnection.deleteOne(itemDetails["_id"]);
//                   },
//                   icon: const Icon(Icons.delete,color: Colors.red),
//                   label: const Text("remove",
//                   style: TextStyle(color: Colors.red),),
//                 ),

//                 const SizedBox(
//                   width: 10,
//                 ),

//                 TextButton.icon(
//                   onPressed: (){}, 
//                   icon: const Icon(Icons.update,color: Colors.orange,), 
//                   label: const Text("update",style: TextStyle(color: Colors.orange),),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
