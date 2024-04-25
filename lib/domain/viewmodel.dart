import 'package:belajar_flutter/domain/use_case.dart';

class MyViewModel {
  final FetchDataUseCase fetchDataUseCase;
  final PostDataUseCase postDataUseCase;

  MyViewModel(this.fetchDataUseCase, this.postDataUseCase);

  Future<String> fetchData() async {
    return await fetchDataUseCase.execute();
  }

  Future<bool> postData(Map<String, dynamic> data) async {
    return await postDataUseCase.execute(data);
  }
}
