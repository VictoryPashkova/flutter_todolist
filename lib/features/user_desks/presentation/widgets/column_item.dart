import 'package:flutter/material.dart';

class ColumnItem extends StatefulWidget {
  final Map<String, dynamic> column;
  final Function(int) onDismissed;
  final Function(String, int) onLongPress;

  const ColumnItem({
    required this.column,
    required this.onDismissed,
    required this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  _ColumnItemState createState() => _ColumnItemState();
}

class _ColumnItemState extends State<ColumnItem> {
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
        widget.onDismissed(widget.column['id'] as int);
      },
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onLongPress: () {
            widget.onLongPress(
                widget.column['name'] as String, widget.column['id'] as int);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              widget.column['name'] as String,
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
