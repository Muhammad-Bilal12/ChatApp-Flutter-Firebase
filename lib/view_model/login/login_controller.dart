import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';

import '../services/session_manager.dart';

class LoginController with ChangeNotifier {
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
  void login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userId = value.user!.uid.toString();
        setLoading(false);
        Utils.showToastMsg(message: "Login Successfully!");
        Navigator.of(context).pushNamed(RouteName.dashboardView);
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
