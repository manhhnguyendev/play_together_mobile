import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.listError,
  }) : super(key: key);

  final List listError;

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
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
        style: const TextStyle(color: Colors.red),
      )),
    );
  }
}
