import 'dart:math';
import 'package:flutter/material.dart';
import 'package:green_vault/screens/info_card.dart';
import 'package:http/http.dart' as http;

class InfoSheet extends StatefulWidget {
  const InfoSheet({super.key});

  @override
  State<InfoSheet> createState() => _InfoSheetState();
}

class _InfoSheetState extends State<InfoSheet> {
  late double details = 0;
  double fill1 = 0;
  double fill2 = 0;
  @override
  void initState() {
    super.initState();
    callFunc();
    fetchData();
  }

  generateData() {
    Random random1 = Random();
    Random random2 = Random();
    fill1 = random1.nextInt(10) + 1;
    fill2 = random2.nextInt(10) + 1;
  }

  fetchData() async {
    try {
      final response =
          await http.get(Uri.parse("http://192.168.4.1/data_endpoint"));
      if (response.statusCode == 200) {
        print("Response from Node MCU: ${response.body}");
        setState(() {
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
      generateData();
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
                    fill: fill1,
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
                    fill: fill2,
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
