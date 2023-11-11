import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/signup/signup_controller.dart';

import '../../res/components/input_text_form_feild.dart';
import '../../res/components/round_button.dart';
import '../../utils/utils.dart';

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

  final _formKey = GlobalKey<FormState>();

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
          child: ChangeNotifierProvider(
            create: (context) => SignupController(),
            child: Consumer<SignupController>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
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
                        key: _formKey,
                        child: Column(
                          children: [
                            InputTextFormFeild(
                              controller: usernameController,
                              focusNode: usernameFocusNode,
                              onFeildSubmittedValue: (value) {
                                Utils.changeFocusNode(context,
                                    currentNode: usernameFocusNode,
                                    nextNode: emailFocusNode);
                              },
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
                              obsecureText: true,
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
                        loading: provider.loading,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.signup(context,
                                username: usernameController.text,
                                email: _emailcontroller.text,
                                password: passwordcontroller.text);
                          }
                        },
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
