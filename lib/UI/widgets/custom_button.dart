import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;

    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.07),
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xffb04904),
          ),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              vertical: deviceSize.height * 0.0,
              horizontal: deviceSize.width * 0.04,
            ),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize:isLand? deviceSize.width * 0.040: deviceSize.width * 0.055,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
