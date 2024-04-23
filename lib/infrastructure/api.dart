import 'dart:convert';
import 'package:http/http.dart' as http;

enum BodyType { urlencoded, json }

class NetworkClient {
  final http.Client httpClient;

  NetworkClient(this.httpClient);

  Future<http.Response> makeRequest(
    String url,
    String path,
    String token, {
    Map<String, int>? data, // Change data type to Map<String, int>?
    BodyType bodyType = BodyType.json,
    Map<String, String>? customHeaders,
    String method = 'POST', // Default to POST method
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $token',
        ...?customHeaders,
      };

      String? body;
      if (data != null) {
        if (bodyType == BodyType.urlencoded) {
          headers['Content-Type'] = 'application/x-www-form-urlencoded';
          body = data.entries
              .map(
                  (entry) => "${Uri.encodeComponent(entry.key)}=${entry.value}")
              .join("&");
        } else if (bodyType == BodyType.json) {
          headers['Content-Type'] = 'application/json';
          // Convert int values to strings before JSON encoding
          final jsonData =
              data.map((key, value) => MapEntry(key, value.toString()));
          body = jsonEncode(jsonData);
        }
      }

      final uri = Uri.https(url, path);

      // Support different HTTP methods
      switch (method.toUpperCase()) {
        case 'GET':
          return await http.get(uri, headers: headers);
        case 'PUT':
          return await http.put(uri, headers: headers, body: body);
        case 'DELETE':
          return await http.delete(uri, headers: headers);
        default:
          // Default to POST
          return await http.post(uri, headers: headers, body: body);
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error making request: $e');
      throw e; // Rethrow the error to propagate it up the call stack
    }
  }
}
