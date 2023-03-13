import 'package:chat_app/UI/widgets/custom_button.dart';
import 'package:flutter/material.dart';

void displayDialog({required BuildContext context, required String message}) {
  TextTheme textContext = Theme.of(context).textTheme;

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          const Icon(Icons.error_outline_outlined, size: 30, color: Colors.red),
          const SizedBox(width: 7),
          Text(
            'An Error Occurred!',
            style: textContext.bodyMedium!.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: textContext.bodySmall,
      ),
      actions: const [
        CustomButton(text: 'Ok'),
      ],
    ),
  );
}
