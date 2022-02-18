import 'package:flutter/material.dart';

background() {
  return BoxDecoration(
    // Box decoration takes a gradient
    gradient: LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      //stops: [0.0, 0.3, 0.6, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Colors.cyan[300]!,
        Colors.cyan[200]!,
        Colors.cyan[100]!,
        //Colors.cyan[50]!,
        //  Colors.green[100]!,
      ],
    ),
  );
}

Widget button(name, function) {
  return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(6.0),
          backgroundColor: MaterialStateProperty.all(
            Colors.cyan[200],
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(
                    width: 2.0,
                    color: Colors.green[100]!,
                  )))),
      onPressed: function,
      child: Text(
        name,
        style: const TextStyle(color: Colors.black, fontSize: 11),
      ));
}
