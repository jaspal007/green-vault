import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WifiPage extends StatefulWidget {
  const WifiPage({super.key});

  @override
  State<WifiPage> createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
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
        actions: <Widget>[
          (true)
              ? TextButton(
                  onPressed: () {
                    // setState(() {});
                  },
                  child: Text(
                    "Stop",
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              : TextButton(
                  onPressed: (){},
                  child: Text(
                    "Scan",
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  "Wifi devices",
                  style: const TextStyle().copyWith(
                    color: Colors.grey.shade600,
                  ),
                  minFontSize: 15,
                  maxFontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
