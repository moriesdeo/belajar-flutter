import 'package:belajar_flutter/data/repositories.dart';

class FetchDataUseCase {
  final DataRepository repository;

  FetchDataUseCase(this.repository);

  Future<String> execute() async {
    return await repository.fetchData();
  }
}

class PostDataUseCase {
  final DataRepository repository;

  PostDataUseCase(this.repository);

  Future<bool> execute(Map<String, dynamic> data) async {
    return await repository.postData(data);
  }
}
