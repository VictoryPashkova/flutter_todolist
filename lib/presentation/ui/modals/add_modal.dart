import 'package:flutter/material.dart';
import '../forms/add_title_form.dart';

class AddModal extends StatelessWidget {
  const AddModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          content: Container(
            width: constraints.maxWidth * 0.8,
            height: 231,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Add new one',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: Color(0xFF2A2A2A),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                      color: const Color(0xFF2A2A2A),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFFF2F2F2),
                        ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: Color(0xFF2A2A2A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.03),
                const AddItemForm(),
              ],
            ),
          ),
        );
      },
    );
  }
}
