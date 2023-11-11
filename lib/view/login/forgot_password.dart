import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/components/input_text_form_feild.dart';
import '../../res/components/round_button.dart';
import '../../utils/utils.dart';
import '../../view_model/forgot_password/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailcontroller = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailcontroller.dispose();
    emailFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0),
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
                  "Forgot Password",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Enter Your Email Address\nto recover your account",
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
                        onFeildSubmittedValue: (value) {},
                        ononValidator: (val) {
                          return val.isEmpty ? "Enter Email" : null;
                        },
                        keyBoardType: TextInputType.emailAddress,
                        hint: "Enter Your Email",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ChangeNotifierProvider(
                  create: (context) => ForgotPasswordController(),
                  child: Consumer<ForgotPasswordController>(
                    builder: (context, provider, child) {
                      return RoundButton(
                        title: "Recover",
                        loading: provider.loading,
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            provider.forgotPassword(
                              context,
                              email: _emailcontroller.text,
                            );
                          }
                        },
                      );
                    },
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
