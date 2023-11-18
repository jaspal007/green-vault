import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_vault/screens/bluetooth_page.dart';
import 'package:green_vault/screens/info_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromRGBO(102, 220, 118, 1),
              Color.fromRGBO(102, 220, 118, 1),
              Color.fromRGBO(10, 213, 143, 1),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "GreenVault",
                ),
              ),
              const Spacer(),
              const InfoSheet(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => Navigator.of(context).push(_createRoute()),
        backgroundColor: const Color.fromRGBO(
          102,
          220,
          118,
          1,
        ),
        child: SvgPicture.asset(
          "lib/assets/GreenVault.svg",
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, aninmation, secondaryAnimation) =>
        const BluetoothPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.easeInOutCirc),
          ),
        ),
        child: child,
      );
    },
  );
}
