import 'package:flutter/material.dart';

import '../../res/components/input_text_form_feild.dart';
import '../../res/components/round_button.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputTextFormFeild(
              controller: _emailcontroller,
              focusNode: emailFocusNode,
              onFeildSubmittedValue: (value) {},
              ononValidator: (val) {
                return val.isEmpty ? "Enter Email" : null;
              },
              keyBoardType: TextInputType.emailAddress,
              hint: "Enter Your Email",
            ),
            RoundButton(
              title: "Login",
              onPress: () {},
            )
          ],
        ),
      ),
    );
  }
}
