import 'package:belajar_flutter/data/data_sources.dart';
import 'package:belajar_flutter/domain/entities.dart';
import 'package:belajar_flutter/domain/viewmodel.dart';
import 'package:belajar_flutter/presentation/componentui.dart';
import 'package:belajar_flutter/presentation/screens.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();

  runApp(const FirstApp());
}

class FirstApp extends StatelessWidget {
  const FirstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
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
  final _passwordController = TextEditingController();
  final _emailValidationModel = ValidationModel(null, null);

  MyViewModel viewModel = getit<MyViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel = getit<MyViewModel>();
  }

  void login(String email, String password) async {
    LoginResponse success = await viewModel.login(email, password);
    if (success.error == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterPage()));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      login(_emailValidationModel.value!, _passwordController.text);
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
              onPressed: _submit,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navigasi ke halaman Register
                navigateToScreen(context, RegisterPage());
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

void navigateToScreen(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
