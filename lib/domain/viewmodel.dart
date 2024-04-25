import 'package:belajar_flutter/domain/entities.dart';
import 'package:belajar_flutter/domain/use_case.dart';

class MyViewModel {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  MyViewModel(this.loginUseCase, this.registerUseCase);

  Future<LoginResponse> login(String email, String password) async {
    return await loginUseCase.login(email, password);
  }
}
