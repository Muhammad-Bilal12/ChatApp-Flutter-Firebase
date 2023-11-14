import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view/dashboard/chat/message_screen.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ref = FirebaseDatabase.instance.ref().child("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {
            if (snapshot.child('uid').value.toString() ==
                SessionController().userId) {
              return SizedBox();
            } else {
              return Card(
                child: ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: MessageScreen(
                        username: snapshot.child('username').value.toString(),
                        email: snapshot.child('email').value.toString(),
                        phone: snapshot.child('phone').value.toString(),
                        recieverId: snapshot.child('uid').value.toString(),
                      ),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.primaryTextTextColor)),
                    child: snapshot.child('profile').value.toString() == ""
                        ? const Icon(Icons.person)
                        : ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  snapshot.child('profile').value.toString()),
                            ),
                          ),
                  ),
                  title: Text(snapshot.child('username').value.toString()),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
