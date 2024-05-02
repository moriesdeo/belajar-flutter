class LoginResponse {
  final bool error;
  final String message;
  final LoginResult loginResult;

  LoginResponse({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      error: json['error'],
      message: json['message'],
      loginResult: LoginResult.fromJson(json['loginResult']),
    );
  }
}

class LoginResult {
  final String userId;
  final String name;
  final String token;

  LoginResult({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      userId: json['userId'],
      name: json['name'],
      token: json['token'],
    );
  }
}

class RegisterResponse {
  final bool error;
  final String message;

  RegisterResponse({required this.error, required this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      error: json['error'],
      message: json['message'],
    );
  }
}

class ListStoriesResponse {
  final bool error;
  final String message;
  final List<Story> listStory;

  ListStoriesResponse({required this.error, required this.message, required this.listStory});

  factory ListStoriesResponse.fromJson(Map<String, dynamic> json) {
    return ListStoriesResponse(
      error: json['error'],
      message: json['message'],
      listStory: List<Story>.from(json['listStory'].map((x) => Story.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
      'listStory': List<dynamic>.from(listStory.map((x) => x.toJson())),
    };
  }
}

class Story {
  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  double lat;
  double lon;

  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photoUrl: json['photoUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
      'lat': lat,
      'lon': lon,
    };
  }
}
