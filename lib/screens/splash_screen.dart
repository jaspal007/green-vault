import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset("lib/assets/GreenVault.svg"),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                ),
                SizedBox(
                  width: width - 113,
                  child: AutoSizeText(
                    "GreenVault", //body medium
                    style: GoogleFonts.merriweather(
                        color: Colors.black,
                        fontSize: 100,
                        fontWeight: FontWeight.w900,),
                    textAlign: TextAlign.center,
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
