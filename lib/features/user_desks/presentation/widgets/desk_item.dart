import 'package:flutter/material.dart';

class DeskItem extends StatefulWidget {
  final Map<String, dynamic> desk;
  final Function(int) onDismissed;
  final Function(String, int) onLongPress;
  final Function(int) onTap;

  const DeskItem({
    required this.desk,
    required this.onDismissed,
    required this.onLongPress,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _DeskItemState createState() => _DeskItemState();
}

class _DeskItemState extends State<DeskItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFFC2534C),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        widget.onDismissed(widget.desk['id'] as int);
      },
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onLongPress: () {
            widget.onLongPress(
                widget.desk['name'] as String, widget.desk['id'] as int);
          },
          onTap: () {
            widget.onTap(widget.desk['id'] as int);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              widget.desk['name'] as String,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color(0xFF2A2A2A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
