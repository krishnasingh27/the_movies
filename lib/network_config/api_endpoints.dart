import 'package:the_movies/network_config/api_config.dart';

class ApiEndPoints {
  static const String popularMovieList = "/movie/popular";
  static const String topRatedMovieList = "/movie/top_rated";
  static const String upcomingMovieList = "/movie/upcoming";
}

extension StringExtension on String {
  String baseURL() {
    return "${ApiConfig.baseURL}$this";
  }

  String ogImgBaseURL() {
    return "${ApiConfig.ogImgBaseURL}$this";
  }

  String w500ImgBaseURL() {
    return "${ApiConfig.w500ImgBaseURL}$this";
  }

  String movieTitle() {
    return "${ApiConfig.w500ImgBaseURL}$this";
  }
}
