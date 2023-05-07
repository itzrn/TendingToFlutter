// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'ItemCard.dart';

// this class is used to display all the data
class AllItems extends StatefulWidget {
  final List<Map<String, Object?>> allItemList;
  const AllItems({super.key, required this.allItemList});

  @override
  State<AllItems> createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text("All Items"),
        backgroundColor: Colors.green[600],
        centerTitle: true,
        elevation: 10.0,
        // shadowColor: Colors.green[50],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widget.allItemList.map((Map<String, Object?> e) {
              return ItemCard(
                  itemDetails: e,
                  delete: () {
                    setState(() {
                      widget.allItemList.remove(e);
                    });
                  });
            }).toList(),
          ),
        ),
      ),
    );
  }
}
