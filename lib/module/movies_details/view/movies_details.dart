import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/constant/backen_constant.dart';
import 'package:movies_app/constant/string_constant.dart';
import 'package:movies_app/module/movies/controller/movies_controller.dart';
import 'package:movies_app/utils/cached_network_image/cahed_network_image.dart';
import 'package:movies_app/utils/custom_text/custom_text.dart';
import 'package:sizer/sizer.dart';

class MoviesDetails extends StatelessWidget {
  final int index;
  final MoviesController moviesController;
  const MoviesDetails({super.key, required this.index, required this.moviesController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade400,
        title: CustomText(text: "Movies Details",textStyle:TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        )),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: 1.h,),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 3.w),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   CustomCachedNetworkImageWithShadow(imageUrl: moviesController.moviesList[index].posterPath,),
                   SizedBox(height: 1.h,),
                   const OverView(),
                   OverViewDetails(title: moviesController.moviesList[index].overview,),
                   const Genres(),
                   GenresList(moviesController: moviesController, index: index,),
                   const ProductionCompanies(),
                   ProductionCompaniesList(moviesController: moviesController,index: index,),
                 ],
               ),
             ),
          ],
        ),
      ),
    );
  }
}

class ProductionCompaniesList extends StatelessWidget {
  final MoviesController moviesController;
  final int index;
  const ProductionCompaniesList({super.key, required this.moviesController, required this.index});

  @override
  Widget build(BuildContext context) {
    return  Obx(()=>
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: moviesController.moviesList[index].productionCompanies.length,
            itemBuilder: (BuildContext context,int companyIndex){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: "$imagesUrl${moviesController.moviesList[index].productionCompanies[companyIndex].logoPath}",
                              errorWidget: (context, url, error) => Image.network(defaultAvatarImage),
                              progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress,color: Colors.green,)),
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  height: 7.h,
                                  width: 7.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 1.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: moviesController.moviesList[index].productionCompanies[companyIndex].name,
                                  textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                CustomText(
                                  text: moviesController.moviesList[index].productionCompanies[companyIndex].originCountry,
                                  textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
    );
  }
}


class ProductionCompanies extends StatelessWidget {
  const ProductionCompanies({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: "Production Companies",
      textStyle: TextStyle(
        fontSize: 16.sp,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}


class OverViewDetails extends StatelessWidget {
  final String title;
  const OverViewDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      maxLines: 6,
      textAlign: TextAlign.justify,
      text: title,
      textStyle: TextStyle(
        fontSize:11.sp,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class GenresList extends StatelessWidget {
  final MoviesController moviesController;
  final int index;
  const GenresList({super.key, required this.moviesController, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: moviesController.moviesList[index].genres.length,
        itemBuilder: (BuildContext context,int genresIndex){
          return CustomText(
            text: moviesController.moviesList[index].genres[genresIndex].name,
            textStyle: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          );
        });
  }
}


class Genres extends StatelessWidget {
  const Genres({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: "Genres",
      textStyle: TextStyle(
        fontSize: 16.sp,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}


class OverView extends StatelessWidget {
  const OverView({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomText(
    text: "OverView:",
    textStyle: TextStyle(
fontSize:16.sp,
color: Colors.black,
fontWeight: FontWeight.w600,
),
);
  }
}

