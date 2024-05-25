import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

class LoadingProgress extends StatelessWidget {
  final bool isLoading;

  const LoadingProgress({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.black.withOpacity(0.3),
            child: const SpinKitFadingCircle(
              color: Colors.white,
              size: 50.0,
            ),
          )
        : Container();
  }
}

class CustomLinearProgressBar extends StatelessWidget {
  const CustomLinearProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 20,
      child: Container(
        width: double.infinity,
        height: 20,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              curve: Curves.linear,
              duration: const Duration(seconds: 1),
              width: 100,
              height: 20,
              color: Colors.blue,
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DeterminateCircularProgressIndicator extends StatefulWidget {
  const DeterminateCircularProgressIndicator({super.key});

  @override
  _DeterminateCircularProgressIndicatorState createState() => _DeterminateCircularProgressIndicatorState();
}

class _DeterminateCircularProgressIndicatorState extends State<DeterminateCircularProgressIndicator> {
  double progress = 0.0;

  void updateProgress() {
    setState(() {
      progress += 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.blue, width: 5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              value: progress,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: updateProgress,
          child: Text('Increase Progress'),
        ),
      ],
    );
  }
}