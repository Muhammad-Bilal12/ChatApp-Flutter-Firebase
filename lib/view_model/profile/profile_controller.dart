import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:tech_media/res/components/input_text_form_feild.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

import '../../utils/routes/route_name.dart';

class ProfileController with ChangeNotifier {
// TextFeild Controller

  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();

// Focus Node

  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  bool _loading = false;

  bool get loading => _loading;

// For loading indicator
  void setLoading(loading) {
    _loading = loading;
    notifyListeners();
  }

// Get Database Reference
  final DatabaseReference dataRef =
      FirebaseDatabase.instance.ref().child('users');
  firebase_storage.FirebaseStorage storage = FirebaseStorage.instance;

// Image Picker

  final picker = ImagePicker();
  XFile? _image;

// getter
  XFile? get image => _image;

// get Image From Galary
  Future<void> pickgalleryImage(context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadimage(context);
      notifyListeners();
    }
  }

  // Capture from Camera
  Future<void> pickCameraImage(context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadimage(context);
      notifyListeners();
    }
  }

// pickImage
  void pickImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 120,
            child: Column(children: [
              ListTile(
                onTap: () {
                  pickCameraImage(context);
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.camera_alt,
                  color: AppColors.primaryIconColor,
                ),
                title: const Text("Camera"),
              ),
              ListTile(
                onTap: () {
                  pickgalleryImage(context);
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.image,
                  color: AppColors.primaryIconColor,
                ),
                title: const Text("Gallery"),
              ),
            ]),
          ),
        );
      },
    );
  }

// upload Image

  void uploadimage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference ref = FirebaseStorage.instance
        .ref('/profileImage' + SessionController().userId!.toString());

    firebase_storage.UploadTask upload =
        ref.putFile(File(image!.path).absolute);

    await Future.value(UploadTask);
    final newUrl = await ref.getDownloadURL();

    dataRef
        .child(SessionController().userId!.toString())
        .update({'profile': newUrl.toString()}).then((value) {
      Utils.showToastMsg(message: "Profile Updated");
      _image = null;
      setLoading(false);
    }).onError((error, stackTrace) {
      Utils.showToastMsg(message: error.toString());
      setLoading(false);
    });
  }

// Update Username
  Future<void> showUserNameDialog(BuildContext context, String name) async {
    _usernameController.text = name;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("Update Username")),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InputTextFormFeild(
                    controller: _usernameController,
                    focusNode: nameFocusNode,
                    onFeildSubmittedValue: (val) {},
                    ononValidator: (val) {},
                    keyBoardType: TextInputType.text,
                    hint: "Enter Username"),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: AppColors.alertColor),
                )),
            TextButton(
                onPressed: () {
                  print("tap");
                  dataRef.child(SessionController().userId.toString()).update({
                    'username': _usernameController.text.toString()
                  }).then((value) {
                    Navigator.pop(context);
                  }).onError((error, stackTrace) {
                    Utils.showToastMsg(message: error.toString());
                  });
                },
                child: Text(
                  "Ok",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: AppColors.primaryTextTextColor),
                )),
          ],
        );
      },
    );
  }

// Update Phone Number
  Future<void> showPhoneDialog(BuildContext context, String number) async {
    _phoneController.text = number;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("Update Phone Number")),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InputTextFormFeild(
                    controller: _phoneController,
                    focusNode: phoneFocusNode,
                    onFeildSubmittedValue: (val) {},
                    ononValidator: (val) {},
                    keyBoardType: TextInputType.phone,
                    hint: "Enter Phone Number"),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: AppColors.alertColor),
                )),
            TextButton(
                onPressed: () {
                  print("tap");
                  dataRef
                      .child(SessionController().userId.toString())
                      .update({'phone': _phoneController.text.toString()}).then(
                          (value) {
                    Navigator.pop(context);
                  }).onError((error, stackTrace) {
                    Utils.showToastMsg(message: error.toString());
                  });
                },
                child: Text(
                  "Ok",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: AppColors.primaryTextTextColor),
                )),
          ],
        );
      },
    );
  }

// Logout User
  void logout(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signOut().then((value) {
      SessionController().userId = '';

      // PersistentNavBarNavigator.pushNewScreen(
      //   context,
      //   screen: LoginView(),
      //   withNavBar: false, // OPTIONAL VALUE. True by default.
      //   pageTransitionAnimation: PageTransitionAnimation.fade,
      // );
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return LoginView();
        },
      ));
    });
  }
}
