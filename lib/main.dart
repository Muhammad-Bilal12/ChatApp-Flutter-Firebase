import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/routes/routes.dart';
import 'package:tech_media/view/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
            height: 1.6,
          ),
          displayMedium: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
            height: 1.6,
          ),
          displaySmall: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
            height: 1.9,
          ),
          headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
            height: 1.9,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.sfProDisplayMedium,
            color: AppColors.primaryTextTextColor,
            height: 1.9,
          ),
          headlineSmall: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.sfProDisplayBold,
            color: AppColors.primaryTextTextColor,
            height: 1.9,
          ),
          bodyLarge: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.sfProDisplayBold,
            color: AppColors.primaryTextTextColor,
            height: 1.9,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontFamily: AppFonts.sfProDisplayRegular,
            color: AppColors.primaryTextTextColor,
            height: 1.9,
          ),
          labelLarge: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.sfProDisplayBold,
            color: AppColors.primaryTextTextColor,
            height: 2.26,
          ),
        ),
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
