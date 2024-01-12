import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:movies_app/module/movies/view/movies_screen.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        themeMode: ThemeMode.system,
        home: const MoviesScreen(),
        builder: EasyLoading.init(),
      );
    });

  }
}
