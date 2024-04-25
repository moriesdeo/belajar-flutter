import 'package:belajar_flutter/data/data_sources.dart';
import 'package:belajar_flutter/domain/viewmodel.dart';
import 'package:belajar_flutter/second.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(
    Provider<MyViewModel>(
      create: (_) => locator<MyViewModel>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = locator<MyViewModel>();
    fetchData();
  }

  void fetchData() async {
    String data = await viewModel.fetchData();
    print("Fetched data: $data");
  }

  void postData(Map<String, dynamic> data) async {
    bool success = await viewModel.postData(data);
    print("Post was successful: $success");
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
      home: const MyHomePage(title: 'Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // final FetchGetAllStoryUseCase? fetchGetAllStoryUseCase;

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
