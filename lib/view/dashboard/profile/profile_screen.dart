import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/view_model/profile/profile_controller.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (context) => ProfileController(),
        child: Consumer<ProfileController>(
          builder: (context, provider, child) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: StreamBuilder(
                    stream: ref.child(SessionController().userId!).onValue,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        Map<dynamic, dynamic> data =
                            snapshot.data.snapshot.value ?? {};

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Center(
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.secondaryTextColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: provider.image == null
                                            ? data['profile'] == ''
                                                ? const Icon(
                                                    Icons.person,
                                                    color: AppColors
                                                        .primaryIconColor,
                                                    size: 50,
                                                  )
                                                : Image(
                                                    image: NetworkImage(
                                                        data['profile']),
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    },
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const Icon(
                                                        Icons.error,
                                                        color: AppColors
                                                            .alertColor,
                                                      );
                                                    },
                                                  )
                                            : Stack(
                                                children: [
                                                  Image.file(
                                                      File(provider.image!.path)
                                                          .absolute),
                                                  const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    provider.pickImage(context);
                                  },
                                  child: const CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        AppColors.primaryButtonColor,
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            GestureDetector(
                              onTap: () {
                                provider.showUserNameDialog(
                                    context, data['username']);
                              },
                              child: ReuseableRow(
                                title: "Username",
                                value: data['username'],
                                iconData: Icons.person_outline,
                              ),
                            ),
                            ReuseableRow(
                              title: "Email",
                              value: data['email'],
                              iconData: Icons.email_outlined,
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.showPhoneDialog(
                                    context, data['phone']);
                              },
                              child: ReuseableRow(
                                title: "Phone Number",
                                value: data['phone'] == ""
                                    ? "xxxx-xxxx-xxx"
                                    : data['phone'],
                                iconData: Icons.phone,
                              ),
                            ),
                            const SizedBox(height: 40),
                            RoundButton(
                                title: "Logout",
                                onPress: () {
                                  provider.logout(context);
                                }),
                          ],
                        );
                      } else {
                        return Center(
                            child: Text(
                          "Something weng Wrong!",
                          style: Theme.of(context).textTheme.labelLarge,
                        ));
                      }
                    }),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  const ReuseableRow(
      {super.key,
      required this.title,
      required this.value,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            iconData,
            color: AppColors.primaryIconColor,
          ),
          title: Text(
            title,
            style:
                Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16),
          ),
          trailing: Text(
            value,
            style:
                Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14),
          ),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.6),
          height: 2,
        ),
      ],
    );
  }
}
