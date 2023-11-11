import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_media/res/color.dart';

class Utils {
// Function to change Focus Node
  static void changeFocusNode(BuildContext context,
      {required FocusNode currentNode, required FocusNode nextNode}) {
    // to close the focus of Current Feild
    currentNode.unfocus();
    // Change Focus
    FocusScope.of(context).requestFocus(nextNode);
  }

// To show Toast message use in Success or error messages
  static showToastMsg({required String message}) {
    // External Pkg to show Toast
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.primaryTextTextColor,
      textColor: AppColors.whiteColor,
      fontSize: 16,
    );
  }
}
