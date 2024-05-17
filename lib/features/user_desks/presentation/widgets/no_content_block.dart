import 'package:flutter/material.dart';

class NoContentBlock extends StatelessWidget {
  const NoContentBlock({
    Key? key,
    required this.noDeskItemImgPath,
    required this.noDeskItemArrowImgPath,
  }) : super(key: key);

  final String noDeskItemImgPath;
  final String noDeskItemArrowImgPath;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      noDeskItemImgPath,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      "You haven't created any desk yet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w400,
                        fontSize: screenHeight * 0.027,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.036,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.174,
                      ),
                      child: Image.asset(
                        noDeskItemArrowImgPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "You haven't created any desk yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: screenHeight * 0.027,
                            color: const Color(0xFF2A2A2A),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Image.asset(
                          noDeskItemImgPath,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.52,
                      ),
                      child: Image.asset(
                        noDeskItemArrowImgPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
