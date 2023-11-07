import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';

import '../../res/components/input_text_form_feild.dart';
import '../../res/components/round_button.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _emailcontroller = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController passwordcontroller = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  final TextEditingController usernameController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailcontroller.dispose();
    emailFocusNode.dispose();

    usernameController.dispose();
    usernameFocusNode.dispose();

    passwordcontroller.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Text(
                  "Welcome To ChatApp",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Enter Your Email Address\nto register your account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      InputTextFormFeild(
                        controller: usernameController,
                        focusNode: usernameFocusNode,
                        onFeildSubmittedValue: (value) {},
                        ononValidator: (val) {
                          return val.isEmpty ? "Enter Username" : null;
                        },
                        keyBoardType: TextInputType.emailAddress,
                        hint: "Enter Username",
                      ),
                      SizedBox(height: height * 0.01),
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
                      SizedBox(height: height * 0.01),
                      InputTextFormFeild(
                        controller: passwordcontroller,
                        focusNode: passwordFocusNode,
                        onFeildSubmittedValue: (value) {},
                        ononValidator: (val) {
                          return val.isEmpty ? "Enter Password" : null;
                        },
                        keyBoardType: TextInputType.emailAddress,
                        hint: "Enter Your Password",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                RoundButton(
                  title: "SignUp",
                  onPress: () {},
                ),
                SizedBox(height: height * 0.01),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteName.loginView);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: "Login",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
