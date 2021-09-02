import 'package:dio/dio.dart';

class DioHelper {
  static Dio? _dio;

  static init() {
    _dio = Dio(BaseOptions(
        baseUrl: 'https://api.themoviedb.org/',
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getData({required String url}) async {
    return await _dio!.get(url).catchError((error) {
      print(error.toString());
    });
  }

  static Future<Response> getVideos({required videosId}) async {
    return await _dio!
        .get(
            'https://api.themoviedb.org/3/movie/$videosId/videos?api_key=837aa67b269303622a476bbe24283a57')
        .catchError((error) {
      print(error.toString());
    });
  }
}
