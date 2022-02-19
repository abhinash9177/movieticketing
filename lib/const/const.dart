import 'package:flutter/material.dart';

background() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.cyan[300]!,
        Colors.cyan[200]!,
        Colors.cyan[100]!,
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

class Mytextfield extends StatelessWidget {
  const Mytextfield({
    Key? key,
    required this.namecontoller,
    required this.hint,
    required this.label,
    required this.keyboard,
  }) : super(key: key);

  final TextEditingController namecontoller;
  final String hint;
  final String label;
  final String keyboard;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          keyboard == 'TEXT' ? TextInputType.text : TextInputType.number,
      controller: namecontoller,
      decoration: InputDecoration(
        helperText: ' ',
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        errorStyle: const TextStyle(
          fontSize: 14,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.white)),
        labelText: (label),
        labelStyle: const TextStyle(color: Colors.black38),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}

Widget datebutton(function) {
  return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  width: 2.0,
                  color: Colors.red[100]!,
                ))),
        elevation: MaterialStateProperty.all(6.0),
        backgroundColor: MaterialStateProperty.all(Colors.cyan[500]),
      ),
      onPressed: function,
      child: const Icon(
        Icons.date_range,
        color: Colors.white,
      ));
}
