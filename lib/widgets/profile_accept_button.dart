import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcceptProfileButton extends StatelessWidget {
  final String text;
  final Function() onPress;
  const AcceptProfileButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      width: 300,
      height: 50,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.black, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40)),
              onPressed: onPress,
              child: Text(
                text,
                style: GoogleFonts.montserrat(
                    color: const Color(0xff320444),
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              )),
        ),
      ),
    );
  }
}
