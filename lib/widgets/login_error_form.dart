import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.listError,
  }) : super(key: key);

  final List listError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        listError.length,
        (index) => formErrorText(listError[index]),
      ),
    );
  }

  Container formErrorText(String error) {
    return Container(
      height: 17,
      alignment: Alignment.centerLeft,
      child: (Text(
        error,
        style: GoogleFonts.montserrat(color: Colors.red),
      )),
    );
  }
}
