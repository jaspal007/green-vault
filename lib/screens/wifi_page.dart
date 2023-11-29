import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WifiPage extends StatefulWidget {
  const WifiPage({super.key});

  @override
  State<WifiPage> createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  String details = "";
  bool getDetails = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const AutoSizeText(
          "GreenVault",
          minFontSize: 15,
          maxFontSize: 20,
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AutoSizeText(
            "Developed By: Jaspal Singh",
            textAlign: TextAlign.center,
            maxFontSize: 20,
            style: const TextStyle().copyWith(
              color: Colors.black87,
            ),
          ),
          AutoSizeText(
            "Version: 1.0.0",
            textAlign: TextAlign.center,
            maxFontSize: 15,
            style: const TextStyle().copyWith(
              color: Colors.grey,
            ),
          ),
          AutoSizeText(
            "Internet Of Things",
            textAlign: TextAlign.center,
            maxFontSize: 15,
            style: const TextStyle().copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      )),
    );
  }
}
