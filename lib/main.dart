import 'package:belajar_flutter/data/data_sources.dart';
import 'package:belajar_flutter/domain/entities.dart';
import 'package:belajar_flutter/domain/viewmodel.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MyViewModel viewModel = locator<MyViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel = locator<MyViewModel>();
    postData({'email': 'abcde@abcd.com', 'password': '11223344'});
    // fetchData();
  }

  void fetchData() async {
    String data = await viewModel.fetchData();
    print("Fetched data: $data");
  }

  void postData(Map<String, dynamic> data) async {
    LoginResponse success = await viewModel.postData(data);
    print("Post was successful: ${success.loginResult.name}");
  }

  @override
  void dispose() {
    // Dispose viewModel if needed, or handle any cleanup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MySecondApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MySecondApp extends StatelessWidget {
  const MySecondApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void navigateToScreen(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

class _MyHomePageState extends State<MyHomePage> {
  void _onFloatingButtonPressed() {
    setState(() {
      navigateToScreen(context, const MyThirdApp());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFloatingButtonPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _loadGetAllStory();
  // }

  // Future<void> _loadGetAllStory() async {
  //   try {
  //     GetAllStories? fetchedAllStory =
  //         await widget.fetchGetAllStoryUseCase?.call(1, 10, 1);
  //     setState(() {
  //       print("xwxw ${fetchedAllStory?.message}");
  //     });
  //   } catch (e) {
  //     setState(() {});
  //   }
  // }
}
