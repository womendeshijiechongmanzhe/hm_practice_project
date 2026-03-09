import 'package:flutter/material.dart';

class ToastUtils {
  static bool isShow = false;
  static void showToast(BuildContext context, String? msg) {
    if (isShow) {
      return;
    }
    isShow = true;
    Future.delayed(Duration(milliseconds: 500), () {
      isShow = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        content: Text(msg ?? "加载成功", textAlign: TextAlign.center),
        width: 200,
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 500),
      ),
    );
  }
}
