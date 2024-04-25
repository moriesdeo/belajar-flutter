import 'dart:convert';

import 'package:belajar_flutter/data/data_sources.dart';
import 'package:belajar_flutter/domain/entities.dart';

abstract class DataRepository {
  Future<LoginResponse> login(String email, String password);
}

class DataRepositoryImpl implements DataRepository {
  final APIClient apiClient;

  DataRepositoryImpl(this.apiClient);

  @override
  Future<LoginResponse> login(String email, String password) async {
    var response = await apiClient.login(email, password);
    if (response.statusCode == 200) {
      // Parse the JSON response into the LoginResponse object
      LoginResponse loginResponse =
          LoginResponse.fromJson(json.decode(response.body));
      // Update the token in the TokenManager
      apiClient.tokenManager.saveToken(loginResponse.loginResult.token);
      return loginResponse;
    } else {
      // Handle non-200 status codes
      throw Exception('Failed to login, status code: ${response.statusCode}');
    }
  }
}
