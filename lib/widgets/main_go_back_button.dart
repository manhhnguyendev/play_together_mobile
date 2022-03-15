import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  final String text;
  final Function() onpress;
  const GoBackButton({
    Key? key,
    required this.text,
    required this.onpress,
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
          //side: BorderSide(color: Colors.black, width: 0.1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FlatButton(
              color: const Color.fromRGBO(112, 113, 123, 1),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              onPressed: onpress,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 17.0),
              )),
        ),
      ),
    );
  }
}
