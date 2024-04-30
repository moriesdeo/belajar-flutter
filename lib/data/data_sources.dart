import 'package:belajar_flutter/data/repositories.dart';
import 'package:belajar_flutter/domain/use_case.dart';
import 'package:belajar_flutter/domain/viewmodel.dart';
import 'package:belajar_flutter/helper/helper.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt getit = GetIt.instance;

void setupLocator() {
  getit.registerLazySingleton(() => Dio());
  getit.registerLazySingleton(() => PrefManager());
  getit.registerLazySingleton(() => APIClient('https://story-api.dicoding.dev/v1', client: getit<Dio>(), tokenManager: getit<PrefManager>()));
  getit.registerFactory(() => MyViewModel(getit<LoginUseCase>(), getit<RegisterUseCase>()));
  getit.registerLazySingleton<DataRepository>(() => DataRepositoryImpl(getit<APIClient>()));
  getit.registerFactory(() => LoginUseCase(getit<DataRepository>()));
  getit.registerFactory(() => RegisterUseCase(getit<DataRepository>()));
}

class APIClient {
  final String _baseUrl;
  final Dio client;
  final PrefManager tokenManager;

  APIClient._internal(this._baseUrl, this.client, this.tokenManager);

  factory APIClient(String baseUrl, {required Dio client, required PrefManager tokenManager}) {
    return APIClient._internal(baseUrl, client, tokenManager);
  }

  Future<Response> login(String email, String password) {
    return client.post(
      '$_baseUrl/login',
      data: <String, String>{
        'email': email,
        'password': password,
      },
    );
  }

  Future<Response> getStories(String token, int page, int size) {
    return client.get(
      '$_baseUrl/stories?page=$page&size=$size',
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      ),
    );
  }

  Future<Response> register(String name, String email, String password) {
    return client.post(
      '$_baseUrl/register',
      data: <String, String>{
        'name': name,
        'email': email,
        'password': password,
      },
    );
  }
}
