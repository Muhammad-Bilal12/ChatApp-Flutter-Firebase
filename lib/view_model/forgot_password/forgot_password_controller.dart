import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';

import '../services/session_manager.dart';

class ForgotPasswordController with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

// For loading indicator
  void setLoading(loading) {
    _loading = loading;
    notifyListeners();
  }

// create firebase authentication instance

  final FirebaseAuth auth = FirebaseAuth.instance;

// For Login Authentication
  void forgotPassword(
    BuildContext context, {
    required String email,
  }) async {
    setLoading(true);
    try {
      auth.sendPasswordResetEmail(email: email).then((value) {
        setLoading(false);
        Utils.showToastMsg(message: "check Your Email");
        Navigator.of(context).pushNamed(RouteName.loginView);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.showToastMsg(message: error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.showToastMsg(message: e.toString());
    }
  }
}
