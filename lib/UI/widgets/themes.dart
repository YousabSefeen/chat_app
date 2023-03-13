import 'package:flutter/material.dart';

class Themes {
  static ThemeData light({
    required BuildContext context,
    required double height,
    required double width,
  }) {

    return ThemeData(
      primarySwatch: Colors.blue,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xffb04904),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0xffb04904),
        centerTitle: true,

      ),
      popupMenuTheme:   PopupMenuThemeData(
        color: const Color(0xffb04904),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        textStyle: TextStyle(
          fontSize: width*0.05,
          color: Colors.white,
          fontWeight: FontWeight.w700
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xffb04904),
        ),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        )),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            vertical: height * 0.010,
            horizontal: width * 0.08,
          ),
        ),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: width * 0.065,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      )),
      cardTheme: CardTheme(
          margin: EdgeInsets.symmetric(horizontal: width * 0.07),
          elevation: 8,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      textTheme: TextTheme(
            bodySmall: TextStyle(
              fontSize: width*0.045,
              color: Colors.grey,
              fontWeight: FontWeight.w600

            ),
        bodyMedium: TextStyle(
          fontSize: width * 0.055,
          color: const Color(0xffb04904),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }


  ///***
///


  static ThemeData dark({
    required BuildContext context,
    required double height,
    required double width,
  }) {
    return ThemeData(
      primarySwatch: Colors.blue,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xffb04904),
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,

      ),
      popupMenuTheme:   PopupMenuThemeData(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: TextStyle(
              fontSize: width*0.05,
              color: Colors.white,
              fontWeight: FontWeight.w700
          )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xffb04904),
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                vertical: height * 0.010,
                horizontal: width * 0.08,
              ),
            ),
            textStyle: MaterialStateProperty.all(
              TextStyle(
                fontSize: width * 0.065,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          )),
      cardTheme: CardTheme(
          margin: EdgeInsets.symmetric(horizontal: width * 0.07),
          elevation: 8,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      textTheme: TextTheme(
        bodySmall: TextStyle(
            fontSize: width*0.045,
            color: Colors.grey,
            fontWeight: FontWeight.w600

        ),
        bodyMedium: TextStyle(
          fontSize: width * 0.055,
          color: const Color(0xffb04904),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
