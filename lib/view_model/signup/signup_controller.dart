import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';

import '../../utils/utils.dart';
import '../services/session_manager.dart';

class SignupController with ChangeNotifier {
// to show loading bar
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

// to get the instance of Firebase Auth

  final FirebaseAuth auth = FirebaseAuth.instance;

  // Create Instance of firebase instance

  final DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');

// to authenticate user and store in database firestore

  void signup(
    BuildContext context, {
    required String username,
    required String email,
    required String password,
  }) async {
// show loading when user cllick on signup

    setLoading(true);

// use Try Catch for error Handling
    try {
      // create new user or Register new user using email and password
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        // store user id
        SessionController().userId = value.user!.uid.toString();

        // to add user data on database

        ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'email': value.user!.email.toString(),
          'username': username,
          'phone': '',
          'profile': '',
          'onlineStatus': 'noOne'
        }).then((value) {
          setLoading(false);
          Navigator.of(context).pushNamed(RouteName.dashboardView);
        }).onError((error, stackTrace) {
          setLoading(false);
          Utils.showToastMsg(message: error.toString());
        });

        Utils.showToastMsg(message: "User Created Succesfully");
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.showToastMsg(message: error.toString());
      });
    } catch (e) {
      setLoading(false);
      // to show error messages
      Utils.showToastMsg(message: e.toString());
    }
  }
}
