import 'package:belajar_flutter/domain/entities.dart';
import 'package:belajar_flutter/domain/use_case.dart';

class MyViewModel {
  final FetchDataUseCase fetchDataUseCase;
  final PostDataUseCase postDataUseCase;

  MyViewModel(this.fetchDataUseCase, this.postDataUseCase);

  Future<String> fetchData() async {
    return await fetchDataUseCase.execute();
  }

  Future<LoginResponse> postData(Map<String, dynamic> data) async {
    return await postDataUseCase.execute(data);
  }

  Future<LoginResponse> login(String email, String password) async {
    return await postDataUseCase.login(email, password);
  }
}
