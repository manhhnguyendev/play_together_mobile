import 'package:flutter/material.dart';

void pushInto(BuildContext context, Widget wg, bool isRightToLeft) {
  Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MaterialApp(home: wg),
        transitionDuration: const Duration(milliseconds: 0),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          var begin = (isRightToLeft == true)
              ? const Offset(50, 0)
              : const Offset(-50, 0);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
      (route) => false);
}

int getDayElapsed(String dateFrom, String dateTo) {
  DateTime from = DateTime.parse(dateFrom);
  DateTime to = DateTime.parse(dateTo);
  from = DateTime(
      from.year, from.month, from.day, from.hour, from.minute, from.second);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
  int difference = to.difference(from).inSeconds;
  return difference;
}
