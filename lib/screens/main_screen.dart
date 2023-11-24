import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_vault/screens/info_sheet.dart';
import 'package:green_vault/screens/wifi_page.dart';

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
          top: false,
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: (height <= 500) ? 0.3 * height : 0.2 * height,
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                alignment: Alignment.centerLeft,
                child: const AutoSizeText(
                  "GreenVault",
                  minFontSize: 10,
                ),
              ),
              const Spacer(),
              const InfoSheet(),
            ],
          ),
        ),
      ),
      floatingActionButton: (height <= 500)
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).push(_createRoute()),
              backgroundColor: const Color.fromRGBO(
                102,
                220,
                118,
                1,
              ),
              child: SvgPicture.asset(
                "lib/assets/GreenVault.svg",
                height: 40,
                width: 40,
                color: Colors.white,
              ),
            )
          : FloatingActionButton.large(
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
      floatingActionButtonLocation: (height <= 500)
          ? FloatingActionButtonLocation.endDocked
          : FloatingActionButtonLocation.centerDocked,
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, aninmation, secondaryAnimation) => const WifiPage(),
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
