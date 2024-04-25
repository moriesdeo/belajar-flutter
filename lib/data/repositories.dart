import 'dart:convert';

import 'package:belajar_flutter/data/data_sources.dart';
import 'package:belajar_flutter/domain/entities.dart';

abstract class DataRepository {
  Future<String> fetchData();
  Future<LoginResponse> postData(Map<String, dynamic> data);
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
  Future<LoginResponse> postData(Map<String, dynamic> data) async {
    var response = await apiClient.postRequest('/login', data);
    if (response.statusCode == 200) {
      // Parse the JSON response into the LoginResponse object
      LoginResponse loginResponse =
          LoginResponse.fromJson(json.decode(response.body));
      // Update the token in the TokenManager
      apiClient.tokenManager.token = loginResponse.loginResult.token;
      return loginResponse;
    } else {
      // Handle non-200 status codes
      throw Exception('Failed to login, status code: ${response.statusCode}');
    }
  }
}
