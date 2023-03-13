import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'custom_field.dart';

class InCaseSignUp extends StatefulWidget {
  final TextEditingController nameController;
  final void Function(File pickedImage)? fetchImage;

  const InCaseSignUp({
    Key? key,
    required this.nameController,
    required this.fetchImage,
  }) : super(key: key);

  @override
  State<InCaseSignUp> createState() => _InCaseSignUpState();
}

class _InCaseSignUpState extends State<InCaseSignUp> {
  File? _image;

  final _pickImage = ImagePicker();

  fetchImage(ImageSource src) async {
    final XFile? imageCapture = await _pickImage.pickImage(
      source: src,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (imageCapture != null) {
      setState(() {
        _image = File(imageCapture.path);
      });
      widget.fetchImage!(_image!);
    } else {
      if (kDebugMode) {
        print('No Image Capture');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    bool isLand = MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          backgroundImage: _image == null ? null : FileImage(_image!),
        ),
        SizedBox(
          height: isLand ? deviceHeight * 0.25 : deviceHeight * 0.12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customButton(
                context: context,
                text: 'Add Image\nFrom Camera.',
                icon: Icons.camera_alt_outlined,
                onPressed: () => fetchImage(ImageSource.camera),
              ),
              customButton(
                context: context,
                text: 'Add Image\nFrom Gallery.',
                icon: Icons.image,
                onPressed: () => fetchImage(ImageSource.gallery),
              ),
            ],
          ),
        ),
        CustomField(
          valueKey: 'user name',
          title: 'User Name',
          hint: 'enter your name',
          controller: widget.nameController,
          boardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }

  ElevatedButton customButton({
    required String text,
    required BuildContext context,
    required IconData icon,
    required void Function()? onPressed,
  }) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 10, horizontal: 7))),
      icon: Icon(
        icon,
        color: const Color(0xffb04904),
        size: deviceWidth * 0.05,
      ),
      label: Text(
        text,
        style: TextStyle(
          fontSize: deviceWidth * 0.04,
          color: Colors.brown,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
