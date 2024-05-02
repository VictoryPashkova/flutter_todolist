import 'package:flutter/material.dart';

export 'tab_bar.dart';

class CustomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 60,
          ),
        ],
      ),
      width: 375,
      height: 105,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            height: 57,
            child: _TabBarItem(
              icon: Icons.phone_iphone_sharp,
              text: 'My desk',
              color: Color(0xFF2A2A2A),
            ),
          ),
          SizedBox(height: 2),
          Container(
            width: 110,
            height: 57,
            child: _TabBarItem(
              icon: Icons.people,
              text: 'Users desks',
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 2),
          Container(
            width: 110,
            height: 57,
            child: _TabBarItem(
              icon: Icons.group,
              text: 'Followed',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _TabBarItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 24,
          weight: 24,
          color: color,
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}
