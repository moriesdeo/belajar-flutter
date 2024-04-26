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

class ValidationModel {
  String? value;
  String? errorMessage;

  ValidationModel(this.value, this.errorMessage);
}

class CustomInputEmail extends StatefulWidget {
  const CustomInputEmail({
    Key? key,
    required this.hintText,
    required this.onSaved,
    required this.validationModel,
    required this.prefIcon,
  }) : super(key: key);

  final String hintText;
  final void Function(String? value) onSaved;
  final ValidationModel validationModel;
  final Icon prefIcon;

  @override
  _CustomInputEmailState createState() => _CustomInputEmailState();
}

class _CustomInputEmailState extends State<CustomInputEmail> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.validationModel.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.validationModel.errorMessage,
        prefixIcon: widget.prefIcon,
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: widget.onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email address';
        }
        if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
