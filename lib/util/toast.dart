import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastOptions {
  String msg;
  Toast? toastLength;
  ToastGravity? gravity;
  Color? backgroundColor;
  Color? textColor;
  int timeInSecForIosWeb;
  double? fontSize;

  ToastOptions(this.msg,
      {this.toastLength = Toast.LENGTH_LONG,
      this.gravity = ToastGravity.CENTER,
      this.backgroundColor,
      this.textColor,
      this.timeInSecForIosWeb = 1,
      this.fontSize});
}

///错误提示样式的toast
void showWarnToast(String text) {
  var toastOp = ToastOptions(text);
  toastOp.backgroundColor = Colors.grey;
  toastOp.textColor = Colors.white;
  _show(toastOp);
}

///普通提示样式的toast
void showToast(String text) {
  var toastOp = ToastOptions(text);
  _show(toastOp);
}

void _show(ToastOptions toastOptions) {
  Fluttertoast.showToast(
      msg: toastOptions.msg,
      toastLength: toastOptions.toastLength,
      gravity: toastOptions.gravity,
      backgroundColor: toastOptions.backgroundColor,
      textColor: toastOptions.textColor,
      timeInSecForIosWeb: toastOptions.timeInSecForIosWeb,
      fontSize: toastOptions.fontSize);
}
