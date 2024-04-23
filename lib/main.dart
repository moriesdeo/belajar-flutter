import 'package:belajar_flutter/domain/entities.dart';
import 'package:belajar_flutter/domain/use_case.dart';
import 'package:belajar_flutter/second.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Home Page',
        fetchGetAllStoryUseCase: null,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key, required this.title, required this.fetchGetAllStoryUseCase});
  final FetchGetAllStoryUseCase? fetchGetAllStoryUseCase;

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
      navigateToScreen(context, MySecondApp());
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
