class UpComing {
  
  late List<Result> result;
  UpComing.fromJson(Map<String, dynamic> json) {
    result = (json['results'] as List).map((e) => Result.fromJson(e)).toList();
  }
}

class Result {
  dynamic id;
  String? inSideImage;
  String? title;
  String? overView;
  String? posterImage;
  String? releaseDate;
  dynamic voteAverage;


  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inSideImage = json['backdrop_path'];
    title = json['original_title'];
    overView = json['overview'];
    posterImage = json['poster_path'];
    releaseDate = json['release_date'];
    voteAverage = json['vote_average'] ;

  }
}
