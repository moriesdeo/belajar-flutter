import 'package:flutter/material.dart';

import '../domain/viewmodel.dart';

class PaginatedListExample extends StatefulWidget {
  const PaginatedListExample({super.key});

  @override
  _PaginatedListExampleState createState() => _PaginatedListExampleState();
}

class _PaginatedListExampleState extends State<PaginatedListExample> {
  final List<String> _items = [];
  bool _isLoading = false;
  int _currentPage = 1;
  late final MyViewModel viewModel;

  void _loadMoreData() {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    // Simulate network request
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _items.addAll(List.generate(20, (index) => 'Item ${_currentPage * 20 + index}'));
        _currentPage++;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Basic Pagination Example")),
      body: ListView.builder(
        itemCount: _items.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _items.length) {
            _loadMoreData();
            return const Center(child: CircularProgressIndicator());
          }
          return ListTile(title: Text(_items[index]));
        },
      ),
    );
  }
}
