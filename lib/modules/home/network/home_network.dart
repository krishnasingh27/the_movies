import 'package:dio/dio.dart';
import 'package:the_movies/modules/home/model/popular_movie_list_modal.dart';
import 'package:the_movies/modules/home/model/top_reated_movie_list.dart';
import 'package:the_movies/modules/home/model/upcoming_movie_list_model.dart';
import 'package:the_movies/network_config/base_network_calls.dart';

class HomeNetworkCalls {
  static Future<PopularMovieListModel?> getPopularMovieList(
      int pageNumber) async {
    Response response = await BaseNetworkCalls().getPopularMovies(pageNumber);
    return PopularMovieListModel.fromJson(response.data);
  }

  static Future<TopRatedMovieListModel?> getTopRatedMovieList() async {
    Response response = await BaseNetworkCalls().getTopRatedMovies();
    return TopRatedMovieListModel.fromJson(response.data);
  }

  static Future<UpcomingMovieListModel?> getUpcomingMovieList() async {
    Response response = await BaseNetworkCalls().getUpcomingMovies();
    return UpcomingMovieListModel.fromJson(response.data);
  }
}
