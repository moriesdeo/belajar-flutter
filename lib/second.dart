import 'package:flutter/material.dart';

class MySecondApp extends StatelessWidget {
  const MySecondApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: const LoginPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Logika untuk Login
      print('Email: $_email, Password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navigasi ke halaman Register
                print('Navigating to register page...');
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                // Logika untuk "Forgot Password"
                print('Forgot password functionality...');
              },
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyThirdApp extends StatelessWidget {
  const MyThirdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Ke 3',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Halaman 3'),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: CustomBackButtonHandler(
          canPop: true, // Set this based on your app's logic
          onPopInvoked: (didPop) async {
            // Implement your custom back press logic here
            // For example, show a confirmation dialog
            if (didPop) {
              bool shouldExit = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm'),
                      content: const Text('Do you really want to exit?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {},
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () => {Navigator.of(context).pop(true)},
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  ) ??
                  false; // Handle null (dialog dismissed)
              return shouldExit;
            }
            return false;
          },
          child: const Center(child: Text('Content of Halaman 3')),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CustomBackButtonHandler extends StatelessWidget {
  final Widget child;
  final bool canPop;
  final Future<bool> Function(bool didPop) onPopInvoked;

  const CustomBackButtonHandler({
    super.key,
    required this.child,
    required this.canPop,
    required this.onPopInvoked,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: onPopInvoked,
      child: child,
    );
  }
}
