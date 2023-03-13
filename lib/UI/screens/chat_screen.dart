import '../../provider/theme_provider.dart';

import ' /../../widgets/stream_messages.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;

    double deviceWidth = MediaQuery.of(context).size.width;

    bool isDark = Provider.of<ThemeProvider>(context).theme == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
          style: TextStyle(
            fontSize:
                isLand ? deviceWidth * 0.045 : deviceWidth * 0.060,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).onChangeTheme();
          },
          icon: Icon(
            isDark ? Icons.sunny : Icons.dark_mode_rounded,
            color: isDark ? Colors.amber : Colors.black,
            size: isLand ? deviceWidth * 0.05 :deviceWidth * 0.08,
          ),
        ),
        actions: [
          buildLogout(deviceWidth, isLand),
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            child: StreamMessages(),
          ),
          NewMessage(),
        ],
      )),
    );
  }

  PopupMenuButton<String> buildLogout(double deviceWidth, bool isLand) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        size: isLand ? deviceWidth * 0.05 : deviceWidth * 0.07,
        color: Colors.white,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'logout',
            child: Row(
              children: [
                Icon(
                  Icons.exit_to_app,
                  size: deviceWidth * 0.08,
                ),
                SizedBox(width: deviceWidth * 0.01),
                const Text('Logout'),
              ],
            ),
          ),
        ];
      },
      onSelected: (value) async {
        if (value == 'logout') {
          await FirebaseAuth.instance.signOut();
        }
      },
    );
  }
}
