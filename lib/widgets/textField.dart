import 'package:flutter/material.dart';

import '../constants.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    Key ? key,
    required this.hintText,
    required this.inputType,
    required this.onChanged,
  }) : super(key: key);
  final String hintText;
  final TextInputType inputType;
  StringWrapper onChanged;
  String ? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: kBodyText.copyWith(color: Colors.black),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onChanged: (v) { this.onChanged.value = v; print(this.onChanged.value); },
      ),
    );
  }
}

class StringWrapper {
  String ? value;
}