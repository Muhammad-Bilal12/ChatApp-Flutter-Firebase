import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class MessageScreen extends StatefulWidget {
  final String username;
  final String email;
  final String phone;
  final String recieverId;

  const MessageScreen(
      {super.key,
      required this.username,
      required this.email,
      required this.phone,
      required this.recieverId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref().child("chat");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.username),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Text(index.toString());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 19,
                            height: 0.0,
                          ),
                      cursorColor: AppColors.primaryTextTextColor,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter Message",
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  height: 0.0,
                                  color: AppColors.primaryTextTextColor
                                      .withOpacity(0.6),
                                ),
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.inputTextBorderColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.secondaryColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            sendMessage();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              backgroundColor: AppColors.primaryButtonColor,
                              child: Icon(
                                Icons.send,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldDefaultBorderColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.alertColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    if (messageController.text.isEmpty) {
      Utils.showToastMsg(message: "Enter Message");
    } else {
      final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      print("Tap");
      print(widget.recieverId.toString());
      ref.child(timeStamp).set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'receiverId': widget.recieverId,
        'type': 'text',
        'time': timeStamp.toString()
      }).then((value) {
        messageController.clear();
      });
    }
  }
}
