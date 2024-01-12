import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/module/movies/controller/movies_controller.dart';
import 'package:movies_app/utils/cached_network_image/cahed_network_image.dart';
import 'package:movies_app/utils/custom_text/custom_text.dart';
import 'package:sizer/sizer.dart';


Future<dynamic> openLengthWeightDialog({
  required context,
  required MoviesController moviesController,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.symmetric(horizontal: 1.5.w,vertical: 1.h),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Favorites Movie",
              textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.lightBlue.shade400,
                  child: const Icon(Icons.close,color: Colors.white,)),
            )
          ],
        ),
        content: SizedBox(
          height: 50.h,
          width: 5.w,
          child: Obx(()=>
          moviesController.favorites.isNotEmpty
              ? ListView.builder(
                shrinkWrap: true,
                itemCount: moviesController.favorites.length,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                    padding: EdgeInsets.only(right: 45.w,left: 1.w),
                    child: SizedBox(
                        width: 5.w,
                        height: 10.h,
                        child: CustomCachedNetworkImage(imageUrl: moviesController.favorites[index],)),
                  );
                }):const CustomText(text: "No Data Found"),
          ),
        ),
      );
    },
  );
}
