import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/module/movies/controller/movies_controller.dart';
import 'package:movies_app/module/movies/widget/favorite_dailog_box.dart';
import 'package:movies_app/module/movies_details/view/movies_details.dart';
import 'package:movies_app/utils/cached_network_image/cahed_network_image.dart';
import 'package:movies_app/utils/custom_text/custom_text.dart';
import 'package:sizer/sizer.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesController moviesController =
    Get.isRegistered<MoviesController>()
        ? Get.find<MoviesController>()
        : Get.put(MoviesController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade400,
        title: CustomText(
          text: "Movies",textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        )
          ,),),
      floatingActionButton: Obx(()=>
         moviesController.favorites.isNotEmpty
            ?FavouriteItemsButton(moviesController: moviesController,):Container(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h,),
            const MoviePosterTitle(),
            SizedBox(height: 1.h,),
            PosterCard(moviesController: moviesController,),
          ],
        ),
      ),
    );
  }
}

class PosterCard extends StatelessWidget {
  final MoviesController moviesController;
  const PosterCard({super.key, required this.moviesController});

  @override
  Widget build(BuildContext context) {
    return  Obx(()=>
    !moviesController.isLoading.value
    ?moviesController.moviesList.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: moviesController.moviesList.length,
            itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                onTap: (){
                  Get.to(()=>MoviesDetails(index: index, moviesController: moviesController));
                },
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  color: Colors.white,
                  child: Column(
                    children: [
                      CustomCachedNetworkImage(imageUrl: moviesController.moviesList[index].posterPath, width: 100.w, height: 30.h,),
                      SizedBox(height: 2.h,),
                      PopularityFavouriteRow(moviesController: moviesController,index: index,),
                      SizedBox(height: 1.h,),
                    ],
                  ),
                ),
              );}):const CustomText(text: "No Data Found"):const Center(child: CircularProgressIndicator(color: Colors.lightBlue,)),
    );
  }
}

class MoviePosterTitle extends StatelessWidget {
  const MoviePosterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomText(
      text: "Movie Poster",
      textStyle: TextStyle(
        fontSize: 16.sp,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}


class PopularityFavouriteRow extends StatelessWidget {
  final MoviesController moviesController;
  final int index;
  const PopularityFavouriteRow({super.key, required this.moviesController, required this.index});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CustomText(
                text: "Popularity:${moviesController.moviesList[index].popularity}",
                textStyle: TextStyle(
                  fontSize:14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              CustomText(
                text: "Budget:${moviesController.moviesList[index].budget}",
                textStyle: TextStyle(
                  fontSize:14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          FavouriteButton(moviesController: moviesController, index: index,),
        ],
      ),
    );
  }
}

class FavouriteButton extends StatelessWidget {
  final MoviesController moviesController;
  final int index;
  const FavouriteButton({super.key, required this.moviesController, required this.index});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        moviesController.addToFavorites(moviesController.moviesList[index].posterPath);
      },
      icon: Obx(()=>
          Icon(
            moviesController.favorites.contains(moviesController.moviesList[index].posterPath)
                ? Icons.favorite:Icons.favorite_border_outlined,
            color: moviesController.favorites.contains(moviesController.moviesList[index].posterPath)
                ? Colors.red
                : Colors.black,
            size: 30,
          ),
      ),
    );
  }
}

class FavouriteItemsButton extends StatelessWidget {
  final MoviesController moviesController;
  const FavouriteItemsButton({super.key, required this.moviesController});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue.shade400),
      ),
      onPressed: (){
        openLengthWeightDialog(context: context, moviesController: moviesController);
      },
      child: CustomText(text: "Favorite Items",textStyle: TextStyle(fontSize: 12.sp,color: Colors.black),),);
  }
}
