import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class SplashServices {
  void isLogin(BuildContext context) {
// create Instance of Firebase Auth

    final FirebaseAuth auth = FirebaseAuth.instance;

    final currentUser = auth.currentUser;

    if (currentUser != null) {
      // user already login

      // store this id
      SessionController().userId = currentUser.uid.toString();

      Timer(
          const Duration(seconds: 3),
          () => Navigator.of(context)
              .pushReplacementNamed(RouteName.dashboardView));
    } else {
      Timer(
          const Duration(seconds: 3),
          () =>
              Navigator.of(context).pushReplacementNamed(RouteName.loginView));
    }
  }
}
