import 'package:flutter/material.dart';

abstract class AllWidgets {
  static Widget customTextField({required String? initialValue,String? labelText,
  String? Error}){
    return TextFormField(
      initialValue: initialValue,
      decoration:  InputDecoration(labelText: labelText),
      validator: (value) {
        if (value!.isEmpty) {
          return Error;
        }
        return null;
      },
      onSaved: (value) {
        initialValue = value;
      },
    );

  }
  static Widget  verticalSpace({double? height}) {
    return SizedBox(
      height: height ?? 10,
    );
  }
}