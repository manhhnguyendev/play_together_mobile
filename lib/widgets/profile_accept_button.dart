import 'package:flutter/material.dart';

class AcceptProfileButton extends StatelessWidget {
  final String text;
  final Function() onpress;
  const AcceptProfileButton({
    Key? key,
    required this.text,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      width: 300,
      height: 50,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.black, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FlatButton(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              onPressed: onpress,
              child:
                  // Text(text,
                  //      style: TextStyle(color: Color.fromRGBO(50, 4, 68, 0.9), fontSize: 16.0),)
                  Text(
                text,
                style:
                    const TextStyle(color: Color(0xff320444), fontSize: 17.0),
              )),
        ),
      ),
    );
  }
}
