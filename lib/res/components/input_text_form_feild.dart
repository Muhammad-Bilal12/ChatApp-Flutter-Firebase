import 'package:flutter/material.dart';

import '../color.dart';

class InputTextFormFeild extends StatelessWidget {
  const InputTextFormFeild({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onFeildSubmittedValue,
    required this.ononValidator,
    required this.keyBoardType,
    required this.hint,
    this.obsecureText = false,
    this.enable = true,
    this.autoFocus = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldSetter onFeildSubmittedValue;
  final FormFieldValidator ononValidator;

  final TextInputType keyBoardType;
  final String hint;
  final bool obsecureText;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onFeildSubmittedValue,
        validator: ononValidator,
        focusNode: focusNode,
        keyboardType: keyBoardType,
        obscureText: obsecureText,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 19,
              height: 0.0,
            ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                height: 0.0,
                color: AppColors.primaryTextTextColor.withOpacity(0.6),
              ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.inputTextBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.textFieldDefaultBorderColor),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.alertColor),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
