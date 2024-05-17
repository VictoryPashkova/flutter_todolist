import 'package:flutter/material.dart';
import '../../../../internal/application.dart';
import 'package:provider/provider.dart';

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
  late final String _itemName = widget.itemName;
  late final TextEditingController _controller =
      TextEditingController(text: _itemName);

  bool _isInputActive = false;

  int _getCurrentPageIndex(BuildContext context) {
    MyAppState myAppState = Provider.of<MyAppState>(context, listen: false);
    int currentPageIndex = myAppState.currentPageIndex;
    return currentPageIndex;
  }

  void _changeDeskTitle(BuildContext context, String text, int id) {
    MyAppState myAppState = Provider.of<MyAppState>(context, listen: false);
    myAppState.changeDeskTitle(text, id);
  }

  void _changeColumnTitle(BuildContext context, String text, int id) {
    MyAppState myAppState = Provider.of<MyAppState>(context, listen: false);
    myAppState.changeColumnTitle(text, id);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.white,
      content: Container(
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0xFF2A2A2A),
                    height: 1.4,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onFieldSubmitted: (value) {
                    if (_getCurrentPageIndex(context) == 0) {
                      _changeDeskTitle(context, _controller.text, widget.id);
                    } else if (_getCurrentPageIndex(context) == 1) {
                      _changeColumnTitle(context, _controller.text, widget.id);
                    }
                    _controller.clear();
                    Navigator.of(context).pop();
                  },
                )
              : Text(
                  widget.itemName,
                  style: const TextStyle(
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
