import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;

              auth.signOut().then((value) {
                SessionController().userId = '';
                Navigator.of(context).pushNamed(RouteName.loginView);
              });
            },
            icon: const Icon(Icons.login_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(SessionController().userId!),
        ],
      ),
    );
  }
}
