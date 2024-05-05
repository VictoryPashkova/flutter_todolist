import 'package:flutter/material.dart';
import '../../../../internal/application.dart';
import 'package:provider/provider.dart';

export 'change_modal.dart';

class ChangeModal extends StatefulWidget {
  final String itemName;
  final int id;

  const ChangeModal({
    Key? key,
    required this.itemName,
    required this.id,
  }) : super(key: key);

  @override
  ChangeModalState createState() => ChangeModalState();
}

class ChangeModalState extends State<ChangeModal> {
  late TextEditingController _controller;
  late String itemName;
  late int id = widget.id;

  bool _isInputActive = false;

  @override
  void initState() {
    super.initState();
    itemName = widget.itemName;
    id = widget.id;
    _controller = TextEditingController(text: itemName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myAppState = Provider.of<MyAppState>(context, listen: false);
    int currentPageIndex = myAppState.currentPageIndex;

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
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isInputActive = true;
            });
          },
          child: _isInputActive
              ? TextFormField(
                  controller: _controller,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0xFF2A2A2A),
                    height: 1.4,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onFieldSubmitted: (value) {
                    if (currentPageIndex == 1) {
                      myAppState.changeDeskTitle(_controller.text, id);
                    } else if (currentPageIndex == 2) {
                      myAppState.changeColumnTitle(_controller.text, id);
                    }
                    _controller.clear();
                    Navigator.of(context).pop();
                  },
                )
              : Text(
                  itemName,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0xFF2A2A2A),
                  ),
                ),
        ),
      ),
    );
  }
}
