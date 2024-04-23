import 'dart:convert';

import 'package:belajar_flutter/infrastructure/api.dart';

class AllStoryDataNetworkSource {
  final NetworkClient client;

  AllStoryDataNetworkSource(this.client);

  Future<dynamic> fetchGetAllStory(int page, int size) async {
    String url = 'https://story-api.dicoding.dev/v1';
    String path = '/endpoint-to-get-all-stories'; // Update endpoint path
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJ1c2VyLXhmVF9rUlVfelhhSHdxczEiLCJpYXQiOjE3MTM4MDgyMjR9.j3G1SxnA4Rs6n6bwxhjZTohYssrTU0uXLJFWzEFKV7g';

    try {
      // Sending request to get all stories
      var response = await client.makeRequest(url, path, token,
          data: {'size': size, 'page': page}, bodyType: BodyType.urlencoded);

      // Checking response status code
      if (response.statusCode == 200) {
        // If successful, parse response body
        return jsonDecode(response.body);
      } else {
        // If request fails, throw an exception
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error fetching all stories: $e');
      throw e;
    }
  }
}
