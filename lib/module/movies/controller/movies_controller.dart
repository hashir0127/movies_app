
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:movies_app/module/movies/model/movie_model.dart';
import 'package:movies_app/network/movie_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviesController extends GetxController{
  RxList<Movie> moviesList=<Movie>[].obs;
  RxList<String> favorites = <String>[].obs;
  RxBool isLoading =false.obs;

  @override
  onInit() {
    getMoviesData();
    super.onInit();
  }

  Future<void> getMoviesData()async{
    moviesList.clear();
    isLoading.value=true;
    List<Movie>? moviesData = await MovieService().getMovies();
    if(moviesData !=null){
      moviesList.addAll(moviesData);
    }
    isLoading.value=false;
  }


  void addToFavorites(String poster) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (favorites.contains(poster)) {
        favorites.remove(poster);
        EasyLoading.showInfo("Movie removed from favorites");
      } else {
        favorites.add(poster);
        EasyLoading.showSuccess("Movie added to favorites");
      }
      prefs.setStringList('favorites', favorites.toList());
    } catch (e) {
      EasyLoading.showError("Error: $e");
    }
  }
}