import 'package:chat_app/UI/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import 'custom_button.dart';

class StreamMessages extends StatelessWidget {
  const StreamMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapShot.hasData) {
          return const Center(
            child: Text('You don\'t have any messages'),
          );
        } else {
          final docs = snapShot.data.docs;

          return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              String userId = FirebaseAuth.instance.currentUser!.uid;
              final isMe = userId == docs[index]['userId'];
              final userName = docs[index]['userName'];
              final userImage = docs[index]['userImage'];
              return InkWell(
                onTap: () => showDetails(
                  context: context,
                  sender: userName,
                  messageDate: docs[index]['dateSending'].toString(),
                  imageSender: userImage,
                ),
                child: MessageBubble(
                  message: docs[index]['text'],
                  userName: userName,
                  isMe: isMe,
                  userImage: userImage,
                ),
              );
              //  return Text(docs[index]['text']);
            },
          );
        }
      },
    );
  }

  showDetails({
    required BuildContext context,
    required String sender,
    required String imageSender,
    required String messageDate,
  }) {
    Size deviceSize = MediaQuery.of(context).size;
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;
    bool isDark = Provider.of<ThemeProvider>(context, listen: false).theme ==
        ThemeMode.dark;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: isDark ? const Color(0xff023047) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              content: SizedBox(
                width: isLand ? deviceSize.width * 0.5 : deviceSize.width * 0.9,
                height: deviceSize.height * 0.5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        'Message Details',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xffb04904),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: deviceSize.height * 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            imageSender,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: isLand
                                ? deviceSize.height * 0.7
                                : deviceSize.height * 0.4,
                          ),
                          SizedBox(height: deviceSize.height * 0.01),
                          customText(
                            text1: 'Sender: ',
                            text2: sender,
                            context: context,
                          ),
                          SizedBox(height: deviceSize.height * 0.02),
                          customText(
                            text1: 'Message Date: ',
                            text2: messageDate,
                            context: context,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: const [
                CustomButton(text: 'Exit'),
              ],
            ));
  }

  RichText customText({
    required String text1,
    required String text2,
    required BuildContext context,
  }) {
    bool isDark = Provider.of<ThemeProvider>(context, listen: false).theme ==
        ThemeMode.dark;

    return RichText(
      text: TextSpan(
        text: text1,
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xffb04904),
          fontWeight: FontWeight.w800,
        ),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
              fontSize: 15,
              color: isDark ? const Color(0xfffefae0) : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
