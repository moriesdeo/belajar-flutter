import 'dart:convert';

import 'package:belajar_flutter/data/data_sources.dart';
import 'package:belajar_flutter/domain/entities.dart';
import 'package:belajar_flutter/domain/model.dart';

abstract class DataRepository {
  Future<MyResponse<LoginResponse>> login(String email, String password);
  Future<RegisterResponse> register(String name, String email, String password);
}

class DataRepositoryImpl implements DataRepository {
  final APIClient apiClient;

  DataRepositoryImpl(this.apiClient);

  @override
  Future<MyResponse<LoginResponse>> login(String email, String password) async {
    var response = await apiClient.login(email, password);
    if (response.statusCode == 200) {
      // Convert the response data to a string before decoding it
      String jsonString = json.encode(response.data);
      // Parse the JSON string into the LoginResponse object
      LoginResponse loginResponse =
          LoginResponse.fromJson(json.decode(jsonString));
      // Update the token in the TokenManager
      apiClient.tokenManager.saveToken(loginResponse.loginResult.token);
      MyResponse<LoginResponse> myResponse = MyResponse(
          statusCode: response.statusCode ?? 0,
          statusMessage: response.statusMessage ?? '',
          data: loginResponse);
      return myResponse;
    } else if (response.statusCode == 401) {
      MyResponse<LoginResponse> myResponse = MyResponse(
          statusCode: response.statusCode ?? 0,
          statusMessage: response.statusMessage ?? '',
          data: null);
      return myResponse;
    } else {
      // Handle non-200 status codes
      throw Exception('Failed to login, status code: ${response.statusCode}');
    }
  }

  @override
  Future<RegisterResponse> register(
      String email, String password, String name) async {
    var response = await apiClient.register(email, password, name);
    if (response.statusCode == 200) {
      String jsonString = json.encode(response);
      RegisterResponse registerResponse =
          RegisterResponse.fromJson(json.decode(jsonString));
      return registerResponse;
    } else {
      // Handle non-200 status codes
      throw Exception('Failed to login, status code: ${response.statusCode}');
    }
  }
}
