import 'package:belajar_flutter/presentation/componentui.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailValidationModel = ValidationModel(null, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DynamicInputWidget(
                controller: _nameController,
                labelText: 'Name',
                prefIcon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                focusNode: FocusNode(),
              ),
              CustomInputEmail(
                hintText: 'Email',
                onSaved: (value) {
                  _emailValidationModel.value = value;
                },
                validationModel: _emailValidationModel,
                prefIcon: const Icon(Icons.email),
              ),
              DynamicInputWidget(
                controller: _passwordController,
                labelText: 'Password',
                prefIcon: const Icon(Icons.lock),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Please enter a password with at least 8 characters';
                  }
                  return null;
                },
                focusNode: FocusNode(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Register user logic here
                    print('Register button pressed');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
