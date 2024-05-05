import 'package:flutter/material.dart';
import '../forms/add_title_form.dart';
import 'package:provider/provider.dart';
import '../../../internal/application.dart';

export 'add_modal.dart';

class AddModal extends StatelessWidget {
  const AddModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MyAppState myAppState = Provider.of<MyAppState>(context);
    int currentPageIndex = myAppState.currentPageIndex;
    String title = currentPageIndex == 1
        ? 'New desk'
        : currentPageIndex == 2
            ? 'New column'
            : '';

    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      contentPadding: EdgeInsets.fromLTRB(24, 32, 24, 40),
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.white,
      content: Container(
        width: 375,
        height: 231,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: Color(0xFF2A2A2A),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                  color: Color(0xFF2A2A2A),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFFF2F2F2),
                      ),
                      textStyle: MaterialStatePropertyAll<TextStyle>(
                        TextStyle(
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Color(0xFF2A2A2A),
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(height: 28),
            AddItemForm(),
          ],
        ),
      ),
    );
  }
}
