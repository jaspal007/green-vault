import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:green_vault/screens/info_card.dart';
import 'package:http/http.dart' as http;

class InfoSheet extends StatefulWidget {
  const InfoSheet({super.key});

  @override
  State<InfoSheet> createState() => _InfoSheetState();
}

class _InfoSheetState extends State<InfoSheet> {
  double details = 0;
  bool getDetails = false;
  @override
  void initState() {
    super.initState();
    callFunc();
  }

  fetchData() async {
    try {
      final response =
          await http.get(Uri.parse("http://192.168.4.1/data_endpoint"));
      if (response.statusCode == 200) {
        print("Response from Node MCU: ${response.body}");
        setState(() {
          getDetails = true;
          details = double.parse(response.body);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void callFunc() async {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 5));
      fetchData();
      setState(() {});
      return true;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print(height);
    print(width);
    return Container(
      width: width,
      height: (height <= 500) ? 0.7 * height : 0.8 * height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0, -1),
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
          ),
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0, -2),
            blurRadius: 15,
            blurStyle: BlurStyle.normal,
          ),
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0, -3),
            blurRadius: 25,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 0.3 * height,
                  width: 0.8 * width,
                  child: InfoCard(
                    type: "Wet Waste",
                    height: 0.3 * height,
                    width: 0.8 * width,
                    fill: details,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                SizedBox(
                  height: 0.3 * height,
                  width: 0.8 * width,
                  child: InfoCard(
                    type: "Dry Waste",
                    height: 0.3 * height,
                    width: 0.8 * width,
                    fill: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
