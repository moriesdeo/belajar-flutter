import 'package:flutter/material.dart';

class DynamicInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Icon prefIcon;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final VoidCallback? toggleObscureText;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isNonPasswordField;

  const DynamicInputWidget({
    required this.controller,
    required this.labelText,
    required this.prefIcon,
    this.validator,
    this.obscureText = false,
    this.toggleObscureText,
    required this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.isNonPasswordField = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefIcon,
      ),
      validator: validator,
      obscureText: obscureText,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(focusNode);
      },
      textInputAction: textInputAction,
      keyboardType: isNonPasswordField
          ? TextInputType.text
          : TextInputType.visiblePassword,
    );
  }
}
