import 'package:belajar_flutter/data/repositories.dart';
import 'package:belajar_flutter/domain/entities.dart';

class FetchDataUseCase {
  final DataRepository repository;

  FetchDataUseCase(this.repository);

  Future<String> execute() async {
    return await repository.fetchData();
  }

  Future<LoginResponse> login(String email, String password) async {
    return await repository.login(email, password);
  }
}

class PostDataUseCase {
  final DataRepository repository;

  PostDataUseCase(this.repository);

  Future<LoginResponse> execute(Map<String, dynamic> data) async {
    return await repository.postData(data);
  }

  Future<LoginResponse> login(String email, String password) async {
    return await repository.login(email, password);
  }
}
