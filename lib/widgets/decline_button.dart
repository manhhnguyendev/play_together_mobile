import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeclineButton extends StatelessWidget {
  final String text;
  final Function() onpress;
  final double height, width;

  const DeclineButton({
    Key? key,
    required this.text,
    required this.onpress,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      width: width,
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FlatButton(
              color: const Color(0xff70717B),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              onPressed: onpress,
              child: Text(
                text,
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 18.0),
              )),
        ),
      ),
    );
  }
}
