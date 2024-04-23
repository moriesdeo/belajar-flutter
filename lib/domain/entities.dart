class GetAllStories {
  bool? error;
  String? message;
  List<ListStory>? listStory;

  GetAllStories({this.error, this.message, this.listStory});

  GetAllStories.fromJson(Map<String, dynamic> json) {
    if (json["error"] is bool) {
      error = json["error"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["listStory"] is List) {
      listStory = json["listStory"] == null
          ? null
          : (json["listStory"] as List)
              .map((e) => ListStory.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["error"] = error;
    _data["message"] = message;
    if (listStory != null) {
      _data["listStory"] = listStory?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ListStory {
  String? id;
  String? name;
  String? description;
  String? photoUrl;
  String? createdAt;
  double? lat;
  double? lon;

  ListStory(
      {this.id,
      this.name,
      this.description,
      this.photoUrl,
      this.createdAt,
      this.lat,
      this.lon});

  ListStory.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["photoUrl"] is String) {
      photoUrl = json["photoUrl"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["lat"] is double) {
      lat = json["lat"];
    }
    if (json["lon"] is double) {
      lon = json["lon"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["photoUrl"] = photoUrl;
    _data["createdAt"] = createdAt;
    _data["lat"] = lat;
    _data["lon"] = lon;
    return _data;
  }
}
