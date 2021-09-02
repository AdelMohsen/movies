class VideosModel {
  dynamic id;
  List<Result>? result;

  VideosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    result = (json['results'] as List).map((e) => Result.fromJson(e)).toList();
  }
}

class Result {
  String? name;
  String? site;
  String? key;
  dynamic size;
  dynamic id;

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    site = json['site'];
    key = json['key'];
    size = json['size'];
  }
}
