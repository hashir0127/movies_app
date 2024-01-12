
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constant/backen_constant.dart';
import 'package:movies_app/constant/string_constant.dart';
import 'package:sizer/sizer.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxShape? shape;
  const CustomCachedNetworkImage({super.key, required this.imageUrl, this.width, this.height, this.shape});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$imagesUrl$imageUrl",
      errorWidget: (context, url, error) => Image.network(defaultAvatarImage),
      progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
          width: width ?? 5.w,
          height:height ?? 5.h,
          child: Center(child: CircularProgressIndicator(value: downloadProgress.progress,color: Colors.green,))),
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width ?? 5.w,
          height:height ?? 5.h,
          decoration: BoxDecoration(
            shape: shape ?? BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}


class CustomCachedNetworkImageWithShadow extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  const CustomCachedNetworkImageWithShadow({super.key, required this.imageUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:"$imagesUrl$imageUrl",
      errorWidget: (context, url, error) => Image.network(defaultAvatarImage),
      progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
          width: 100.w,
          height: 30.h,
          child: Center(child: CircularProgressIndicator(value: downloadProgress.progress,color: Colors.green,))),
      imageBuilder: (context, imageProvider) {
        return Container(
          width: 100.w,
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // You can customize the shadow color and opacity
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Offset in x and y directions
              ),
            ],
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

