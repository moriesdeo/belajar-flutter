import 'package:belajar_flutter/presentation/componentui.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                prefIcon: Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                focusNode: FocusNode(),
              ),
              DynamicInputWidget(
                controller: _emailController,
                labelText: 'Email',
                prefIcon: Icon(Icons.email),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                focusNode: FocusNode(),
              ),
              DynamicInputWidget(
                controller: _passwordController,
                labelText: 'Password',
                prefIcon: Icon(Icons.lock),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Please enter a password with at least 8 characters';
                  }
                  return null;
                },
                focusNode: FocusNode(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Register user logic here
                    print('Register button pressed');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
