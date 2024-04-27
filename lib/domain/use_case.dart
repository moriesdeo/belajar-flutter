import 'package:belajar_flutter/data/repositories.dart';
import 'package:belajar_flutter/domain/entities.dart';
import 'package:belajar_flutter/domain/model.dart';

class LoginUseCase {
  final DataRepository repository;

  LoginUseCase(this.repository);

  Future<MyResponse<LoginResponse>> login(String email, String password) async {
    return await repository.login(email, password);
  }
}

class RegisterUseCase {
  final DataRepository repository;

  RegisterUseCase(this.repository);

  Future<RegisterResponse> register(
      String email, String password, String name) async {
    return await repository.register(email, password, name);
  }
}
