import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../internal/application.dart';
import '../../../features/user_desks/presentation/pages/user_dashboard_all_desks.dart';
import '../../../features/user_dashboard/presentation/pages/user_dashboard_page.dart';

export 'tab_bar_desk.dart';

class TabBarDesk extends StatefulWidget {
  @override
  _TabBarDeskState createState() => _TabBarDeskState();
}

class _TabBarDeskState extends State<TabBarDesk> {
  @override
  Widget build(BuildContext context) {
    MyAppState myAppState = Provider.of<MyAppState>(context);
    int currentPageIndex = myAppState.currentPageIndex;
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
          _buildTabBarItem(
              Icons.my_library_add_rounded, 'All Desks', 1, currentPageIndex),
          SizedBox(height: 2),
          _buildTabBarItem(
              Icons.desktop_mac, 'Current desk', 2, currentPageIndex),
          SizedBox(height: 2),
          _buildTabBarItem(Icons.group, 'Followed', 3, currentPageIndex),
        ],
      ),
    );
  }

  Widget _buildTabBarItem(
      IconData icon, String text, int pageIndex, int currentPageIndex) {
    MyAppState myAppState = Provider.of<MyAppState>(context);
    final id = myAppState.currentDeskId;
    final itemName = myAppState.currentDeskName;
    return GestureDetector(
      onTap: () {
        myAppState.setPageIndex(pageIndex);
        if (pageIndex == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserDashboardPage(
                      id: id,
                      itemName: itemName,
                    )),
          );
        } else if (pageIndex == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserDashboardAllDesksPage()),
          );
        }
      },
      child: SizedBox(
        width: 110,
        height: 57,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: currentPageIndex == pageIndex
                  ? Color(0xFF2A2A2A)
                  : Colors.grey,
            ),
            SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: currentPageIndex == pageIndex
                    ? Color(0xFF2A2A2A)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
