import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function() onPress;

  const MainButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      width: size.width,
      height: size.height / 15,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(137, 128, 255, 1),
            ),
            child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40)),
                onPressed: onPress,
                child: Text(
                  text,
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontSize: 18.0),
                )),
          ),
        ),
      ),
    );
  }
}
