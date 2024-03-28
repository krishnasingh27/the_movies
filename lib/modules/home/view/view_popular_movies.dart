import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movies/modules/home/model/popular_movie_list_modal.dart';
import 'package:the_movies/modules/home/network/home_network.dart';
import 'package:the_movies/network_config/api_endpoints.dart';

class ViewPopularMovies extends StatefulWidget {
  const ViewPopularMovies({super.key});

  @override
  State<ViewPopularMovies> createState() => _ViewPopularMoviesState();
}

class _ViewPopularMoviesState extends State<ViewPopularMovies> {
  ScrollController scrollController = ScrollController();
  static PopularMovieListModel? popularMovieListModal;

  List<Results> popularMovieList = [];

  int pageNumber = 1;
  bool stopLoading = false;
  bool isLoading = false;

  @override
  void initState() {
    getMovieList();
    Future.delayed(const Duration(seconds: 3), () {
      scrollListener();
    });
    super.initState();
  }

  double boundaryOffset = 0.5;

  getMovieList() async {
    popularMovieListModal =
        await HomeNetworkCalls.getPopularMovieList(pageNumber);
    setState(() {
      popularMovieList.addAll(popularMovieListModal?.results ?? []);
      if ((popularMovieListModal?.results ?? []).isNotEmpty &&
          (popularMovieList.length) % 20 == 0) {
        pageNumber++;
        isLoading = false;
        setState(() {});
      } else {
        stopLoading = true;
        isLoading = false;
      }
    });
  }

  scrollListener() {
    if (!stopLoading) {
      //load more data
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent * boundaryOffset &&
          !isLoading) {
        print(
            "----------------------------Fuck-------------------------------");
        isLoading = true;
        getMovieList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Movies')),
      body: Flexible(
        child: GridView.builder(
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // number of items in each row
              mainAxisSpacing: 8.0, // spacing between rows
              crossAxisSpacing: 8.0, // spacing between columns
              mainAxisExtent: 350,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8.0), // padding around the grid
            itemCount: popularMovieList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(
                                (popularMovieList[index].posterPath ?? "")
                                    .w500ImgBaseURL()),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 40,
                      width: 180,
                      child: Text(
                        popularMovieList[index].title ?? "",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 15),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
