import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/login/login_controller.dart';

import '../../res/components/input_text_form_feild.dart';
import '../../res/components/round_button.dart';
import '../../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailcontroller = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController passwordcontroller = TextEditingController();

  final FocusNode passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailcontroller.dispose();
    emailFocusNode.dispose();

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
                  "Enter Your Email Address\nto connect to your account",
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
                        controller: _emailcontroller,
                        focusNode: emailFocusNode,
                        onFeildSubmittedValue: (value) {
                          Utils.changeFocusNode(context,
                              currentNode: emailFocusNode,
                              nextNode: passwordFocusNode);
                        },
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
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteName.forgotPasswordView);
                    },
                    child: Text(
                      "Forgot Password",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ChangeNotifierProvider(
                  create: (context) => LoginController(),
                  child: Consumer<LoginController>(
                    builder: (context, provider, child) {
                      return RoundButton(
                        title: "Login",
                        loading: provider.loading,
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            provider.login(context,
                                email: _emailcontroller.text,
                                password: passwordcontroller.text);
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: height * 0.01),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteName.signUpView);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: "Signup",
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
