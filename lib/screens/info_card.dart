import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  final String type;
  final double height;
  final double width;
  final double fill;
  const InfoCard({
    super.key,
    required this.type,
    required this.height,
    required this.width,
    required this.fill,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    final width = 0.9 * widget.width;
    final height = widget.height;
    final ratio = (widget.fill / 20) > 1 ? 1 : (widget.fill / 20);
    final fill = ratio * width;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 5),
            blurRadius: 20,
          ),
        ],
      ),
      child: Card(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 60,
            ),
            child: (MediaQuery.of(context).size.height <= 500)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: height * 0.25,
                        child: AutoSizeText(
                          widget.type,
                          minFontSize: 5,
                          maxLines: 1,
                        ),
                      ),
                      // const Spacer(),
                      Container(
                        // alignment: Alignment.center,
                        // color: Colors.purple,
                        // width: (ratio <= 0.1) ? 0.12 * width : fill,
                        // padding: EdgeInsets.only(left: fill / 2),
                        child: AutoSizeText(
                          '${(ratio * 100).truncate()}%',
                          maxFontSize: 20,
                          maxLines: 1,
                        ),
                      ),
                      // Stack(
                      //   children: [
                      //     Container(
                      //       width: width,
                      //       height: 15,
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey.shade400,
                      //         borderRadius: const BorderRadius.all(
                      //           Radius.circular(60),
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       width: fill,
                      //       height: 15,
                      //       decoration: BoxDecoration(
                      //         color: (fill >= 0.8 * width)
                      //             ? Colors.red
                      //             : (fill >= 0.5 * width)
                      //                 ? Colors.orangeAccent
                      //                 : Colors.green,
                      //         borderRadius: const BorderRadius.all(
                      //           Radius.circular(60),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: height * 0.25,
                        child: AutoSizeText(
                          widget.type,
                          minFontSize: 5,
                          maxLines: 1,
                        ),
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          Container(
                            width: width,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(60),
                              ),
                            ),
                          ),
                          Container(
                            width: fill,
                            height: 15,
                            decoration: BoxDecoration(
                              color: (fill >= 0.8 * width)
                                  ? Colors.red
                                  : (fill >= 0.5 * width)
                                      ? Colors.orangeAccent
                                      : Colors.green,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(60),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            // color: Colors.purple,
                            width: (ratio <= 0.1) ? 0.12 * width : fill,
                            // padding: EdgeInsets.only(left: fill / 2),
                            child: AutoSizeText(
                              '${(ratio * 100).truncate()}%',
                              maxFontSize: 12,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
