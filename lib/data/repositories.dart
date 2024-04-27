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
      String jsonString = json.encode(response.data);
      LoginResponse loginResponse =
          LoginResponse.fromJson(json.decode(jsonString));
      apiClient.tokenManager.saveToken(loginResponse.loginResult.token);
      return MyResponse(
          statusCode: response.statusCode ?? 0,
          statusMessage: response.statusMessage ?? '',
          data: loginResponse);
    } else {
      // Handle non-200 status codes by parsing the error message if available
      String statusMessage = '';
      try {
        // Attempt to decode the error message from the response
        var decoded = json.decode(response.data);
        statusMessage = decoded['message'] ?? 'No error message provided';
      } catch (e) {
        // If there's an error in parsing, use the default status message
        statusMessage =
            response.statusMessage ?? 'Failed to process the request';
      }
      return MyResponse<LoginResponse>(
          statusCode: response.statusCode ?? 0,
          statusMessage: statusMessage,
          data: null);
    }
  }

  @override
  Future<RegisterResponse> register(String name, String email,
      String password) async {
    var response = await apiClient.register(email, password, name);
    if (response.statusCode == 200) {
      String jsonString = json.encode(response);
      RegisterResponse registerResponse =
          RegisterResponse.fromJson(json.decode(jsonString));
      return registerResponse;
    } else {
      // Handle non-200 status codes
      throw Exception(
          'Failed to register, status code: ${response.statusCode}');
    }
  }
}
