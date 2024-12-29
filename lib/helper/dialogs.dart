import 'package:flutter/material.dart';

class Dialogs {
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontSize: 20.0, // Kích thước chữ
          fontWeight: FontWeight.bold, // Độ dày chữ
          color: Colors.white, // Màu chữ
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 113, 205),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(context: context,builder: (_) => Center(child: CircularProgressIndicator()));
  }
}
