import 'package:belajar_flutter/data/data_sources.dart';
import 'package:belajar_flutter/domain/viewmodel.dart';
import 'package:belajar_flutter/helper/helper.dart';
import 'package:belajar_flutter/helper/util.dart';
import 'package:belajar_flutter/presentation/componentui.dart';
import 'package:belajar_flutter/presentation/screens.dart';
import 'package:belajar_flutter/ui/dashboard.dart';
import 'package:flutter/material.dart';

import 'app_end.dart';

void main() {
  setupLocator();
  runApp(const FirstApp());
}

class FirstApp extends StatelessWidget {
  const FirstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(Localization.getString('app_title', locale: '')),
        ),
        body: const MyCustomPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AlignPage extends StatefulWidget {
  const AlignPage({super.key});

  @override
  State<AlignPage> createState() => _AlignPageState();
}

class _AlignPageState extends State<AlignPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Widget paling atas
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Text('wkkwkwkwwkkwwkwkwk'),
              Text('wkkwkwkwwkkwwkwkwk'),
              Text('wkkwkwkwwkkwwkwkwk'),
              Text('wkkwkwkwwkkwwkwkwk'),
              Text('wkkwkwkwwkkwwkwkwk'),
              Text('wkkwkwkwwkkwwkwkwk'),
              Text('wkkwkwkwwkkwwkwkwk'),
              Text('wkkwkwkwwkkwwkwkwk'),
              Text('wkkwkwkwwkkwwkwkwk'),
              Text('wkkwkwkwwkkwwkwkwk'),
              Text('wkkwkwkwwkkwwkwkwk'),
              Text('wkkwkwkwwkkwwkwkwk'),
            ],
          ),
        ),
        // Expanded untuk mengisi ruang di antara widget atas dan bawah
        Expanded(child: Container()),
        // Widget paling bawah
        Align(
          alignment: Alignment.bottomCenter,
          child: Text('wkkwkwkwwkkwwkwkwk'),
        ),
      ],
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
  final prefManager = PrefManager();
  bool _isLoading = false;
  late final MyViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getit<MyViewModel>();
    _isLoading = false;
    checkLoggedIn();
  }

  Future<void> checkLoggedIn() async {
    if (await prefManager.isLoggedIn() ?? false) {
      navigateToScreen(context, const DashboardApp());
    }
  }

  void login(String email, String password) async {
    try {
      final success = await viewModel.login(email, password);
      if (success.statusCode == 200 && success.data!.error == false) {
        prefManager.setLoggedIn(true);
        navigateToScreen(context, const DashboardApp());
      } else {
        _showAlertDialog(statusCode: success.statusCode, statusMessage: success.statusMessage);
      }
    } catch (error) {
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAlertDialog({required int statusCode, required String statusMessage}) {
    AlertDialogPositoveUtil.showPositiveAlertDialog(
      context: context,
      title: statusCode.toString(),
      content: statusMessage,
      onPositiveBtnTap: () {
        Navigator.of(context).pop();
      },
    );
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
            LoadingProgress(isLoading: _isLoading),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () async {
                navigateToScreen(context, const RegisterPage());
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                print('Forgot password functionality...');
              },
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      login(_emailValidationModel.value!, _passwordController.text);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}

class CustomBackButtonHandler extends StatelessWidget {
  final Widget child;
  final bool canPop;
  final Future<bool> Function(bool didPop) onPopInvoked;

  const CustomBackButtonHandler({super.key, required this.child, required this.canPop, required this.onPopInvoked});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: onPopInvoked,
      child: child,
    );
  }
}
