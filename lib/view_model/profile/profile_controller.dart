import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/res/color.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class ProfileController with ChangeNotifier {
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
}
