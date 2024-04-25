import 'package:belajar_flutter/data/data_sources.dart';

abstract class DataRepository {
  Future<String> fetchData();
  Future<bool> postData(Map<String, dynamic> data);
}

class DataRepositoryImpl implements DataRepository {
  final APIClient apiClient;

  DataRepositoryImpl(this.apiClient);

  @override
  Future<String> fetchData() async {
    var response = await apiClient.getRequest('/data');
    return response.body;
  }

  @override
  Future<bool> postData(Map<String, dynamic> data) async {
    var response = await apiClient.postRequest('/submit', data);
    return response.statusCode == 200;
  }
}
