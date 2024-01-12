

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies_app/module/movies/model/movie_model.dart';
import 'package:movies_app/network/backend_call.dart';

class MovieService{

 Future<List<Movie>?> getMovies()async{
   try{
     List<Movie> moviesList = [];
     Map<String, dynamic> map = await BackendCall().getRequest();
     if (map.containsKey('genres')){
         moviesList.add(Movie.fromJson(map));
     }
     return moviesList;
   }catch(e){
     EasyLoading.showError("Error to mapData:$e");
     return [];
   }
 }


}