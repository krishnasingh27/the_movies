import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movies/modules/home/model/popular_movie_list_modal.dart';
import 'package:the_movies/modules/home/model/top_reated_movie_list.dart';
import 'package:the_movies/modules/home/model/upcoming_movie_list_model.dart';
import 'package:the_movies/modules/home/network/home_network.dart';
import 'package:the_movies/modules/home/view/view_popular_movies.dart';
import 'package:the_movies/modules/search/view/search.dart';
import 'package:the_movies/network_config/api_endpoints.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static PopularMovieListModel? popularMovieListModal;
  static TopRatedMovieListModel? topRatedMovieListModel;
  static UpcomingMovieListModel? upcomingMovieListModel;

  @override
  void initState() {
    getMovieList();
    super.initState();
  }

  int pageNumber = 1;

  getMovieList() async {
    popularMovieListModal =
        await HomeNetworkCalls.getPopularMovieList(pageNumber);
    topRatedMovieListModel = await HomeNetworkCalls.getTopRatedMovieList();
    upcomingMovieListModel = await HomeNetworkCalls.getUpcomingMovieList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        drawer: const Drawer(),
        body: popularMovieListModal?.results == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    header1(),
                    movieSlider(),
                    header2(),
                    movieSlider2(),
                    header3(),
                    bigmovieSlider(),
                    header4(),
                    movieSlider4()
                  ],
                ),
              ));
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text("Home"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Search()));
            },
            icon: const Icon(Icons.search))
      ],
    );
  }

  Widget header1() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("Popular",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewPopularMovies()));
            },
            child: Container(
              height: 28,
              width: 45,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Text(
                  "All",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget movieSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 240,
        width: double.infinity,
        child: Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularMovieListModal?.results?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage((popularMovieListModal
                                          ?.results?[index].posterPath ??
                                      "")
                                  .w500ImgBaseURL()),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        height: 30,
                        width: 100,
                        child: Text(
                          popularMovieListModal?.results?[index].title ?? "",
                          style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w500, fontSize: 10),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget header2() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0, left: 8, right: 8),
          child: Text("Top Rated",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 28,
            width: 45,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const Center(
              child: Text(
                "All",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget movieSlider2() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 240,
        width: double.infinity,
        child: Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topRatedMovieListModel?.results?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage((topRatedMovieListModel
                                          ?.results?[index].posterPath ??
                                      "")
                                  .w500ImgBaseURL()),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        height: 30,
                        width: 100,
                        child: Text(
                          topRatedMovieListModel?.results?[index].title ?? "",
                          style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w500, fontSize: 10),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget header3() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0, left: 8, right: 8),
          child: Text("Now Playing",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 28,
            width: 45,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const Center(
              child: Text(
                "All",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget bigmovieSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage((popularMovieListModal
                                      ?.results?[index].posterPath ??
                                  "")
                              .w500ImgBaseURL()),
                          fit: BoxFit.cover)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget header4() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0, left: 8, right: 8),
          child: Text("Upcomming",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 28,
            width: 45,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const Center(
              child: Text(
                "All",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget movieSlider4() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 240,
        width: double.infinity,
        child: Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: upcomingMovieListModel?.results?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage((upcomingMovieListModel
                                          ?.results?[index].posterPath ??
                                      "")
                                  .w500ImgBaseURL()),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        height: 30,
                        width: 100,
                        child: Text(
                          upcomingMovieListModel?.results?[index].title ?? "",
                          style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w500, fontSize: 10),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
