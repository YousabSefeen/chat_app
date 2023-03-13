import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  String _message = '';

  void _sendMessage() async {
    String user = FirebaseAuth.instance.currentUser!.uid;
    // The following line describes. When a registration is sent by the user,
    // a username is sent to the fireStore
    // Therefore, I extract it now and display it with the message.
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(user).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _messageController.text.trim(),
      'dateSending': DateFormat.yMd().add_jm().format(DateTime.now()),
      'createdAt': Timestamp.now(),
      'userId': user,
      'userName': userData['userName'],
      'userImage': userData['userImage'],
    });

    setState(() {
      _messageController.clear();
      _message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;
    bool isDark = Provider.of<ThemeProvider>(context).theme == ThemeMode.dark;
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: deviceHeight * 0.01,
            horizontal: deviceWidth * 0.02,
          ),
          width: isLand ? deviceWidth * 0.85 : deviceWidth * 0.8,
          child: TextFormField(
            textCapitalization: TextCapitalization.none,
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Send a message..',
              hintStyle: TextStyle(
                fontSize: deviceWidth * 0.040,
                color: isDark ? Colors.white70 : Colors.black54,
                fontWeight: FontWeight.w800,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              filled: true,
              fillColor:
                  isDark ? const Color(0xff023047) : const Color(0xfff9b13e),
            ),
            style: TextStyle(
              fontSize: isLand ? deviceWidth * 0.035 : deviceWidth * 0.048,
              color: isDark ? const Color(0xfffefae0) : Colors.black,
              fontWeight: FontWeight.w700,
            ),
            maxLines:isLand? 1:3,
            minLines: 1,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                _message = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: deviceWidth * 0.02),
          child: CircleAvatar(
            radius: 22,
            backgroundColor:
                _message.isEmpty ? Colors.grey : const Color(0xffb04904),
            child: IconButton(
              splashRadius: 12,
              icon: Icon(
                Icons.send,
                size: isLand ? deviceWidth * 0.03 : deviceWidth * 0.06,
                color: Colors.white,
              ),
              onPressed:
                  _messageController.text.trim() == '' ? null : _sendMessage,
            ),
          ),
        ),
      ],
    );
  }
}
