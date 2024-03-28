import 'package:dio/dio.dart';
import 'package:the_movies/network_config/api_config.dart';
import 'package:the_movies/network_config/api_endpoints.dart';

class BaseNetworkCalls {
  Dio dio = Dio();

  Future<Response> getPopularMovies(int pageNo) async {
    Response response = await dio.get(
        ApiEndPoints.popularMovieList.baseURL() + "?page = $pageNo",
        options: Options(headers: {
          "Authorization": "Bearer ${ApiConfig.bearerToken}",
        }));
    return response;
  }

  Future<Response> getTopRatedMovies() async {
    Response response = await dio.get(ApiEndPoints.topRatedMovieList.baseURL(),
        options: Options(headers: {
          "Authorization": "Bearer ${ApiConfig.bearerToken}",
        }));
    return response;
  }

  Future<Response> getUpcomingMovies() async {
    Response response = await dio.get(ApiEndPoints.upcomingMovieList.baseURL(),
        options: Options(headers: {
          "Authorization": "Bearer ${ApiConfig.bearerToken}",
        }));
    return response;
  }
}
