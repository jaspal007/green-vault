import 'package:flutter/material.dart';
import 'package:green_vault/screens/info_card.dart';

class InfoSheet extends StatelessWidget {
  const InfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print(height);
    print(width);
    return Container(
      width: width,
      height: 0.8 * height,
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
                  fill: 5,
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
                  fill: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
