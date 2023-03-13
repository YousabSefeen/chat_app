import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.userName,
    required this.userImage,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    bool isDark = Provider.of<ThemeProvider>(context).theme == ThemeMode.dark;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
              child: CircleAvatar(
                backgroundImage: NetworkImage(userImage),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.02,
                horizontal: deviceWidth * 0.03,
              ),
              margin: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.0,
                horizontal: deviceWidth * 0.03,
              ),
              decoration: BoxDecoration(
                color: isMe
                    ? isDark
                        ? const Color(0xff023047)
                        : const Color(0xffb04904)
                    : Colors.grey,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(25),
                  topLeft: const Radius.circular(25),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(25),
                  bottomLeft: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(25),
                ),
              ),
              constraints: BoxConstraints(
                maxWidth: deviceWidth * 0.75,
                minWidth: deviceWidth * 0.2,
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: isLand ? deviceWidth * 0.030 : deviceWidth * 0.045,
                  color: isMe
                      ? isDark
                          ? const Color(0xfffefae0)
                          : Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
          ],
        ),
      ],
    );
  }
}
