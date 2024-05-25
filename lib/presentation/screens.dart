import 'package:belajar_flutter/presentation/componentui.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Custom actions before leaving the page
            // For example, popping with data or showing a dialog
            Navigator.pop(context, 'wkwkwkwkwkwk');
            print('ckckckckckckckc');
          },
        ),
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

class MyCustomPage extends StatelessWidget {
  const MyCustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          // Perform your logic here if the pop action was not successful
          final shouldPop = await showConfirmDialog(context);
          if (shouldPop) {
            Navigator.of(context).pop();
          }
          return;
        }
        // Handle the case when pop was successful
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Custom Back Navigation")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: TestPage(),
        ),
      ),
    );
  }

  Future<bool> showConfirmDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm'),
            content: const Text('Do you want to leave this page?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; // Returning false if showDialog returns null
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index < 20) {
                return Card(
                  child: Center(
                    child: Text("Item $index"),
                  ),
                );
              } else {
                return null;
              }
            },
            childCount: 20,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            List.generate(30, (index) => Text('data')),
          ),
        ),
      ],
    );
  }
}
