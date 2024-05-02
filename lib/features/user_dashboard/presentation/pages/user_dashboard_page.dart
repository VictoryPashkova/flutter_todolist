import 'package:flutter/material.dart';
import 'package:flutter_todolist/presentation/ui/primary_botton/exit_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_style/dart_style.dart';
import '../widgits/tab_bar.dart';
import '../../../../presentation/ui/primary_botton/exit_button.dart';
import '../widgits/add_column_modal.dart';
import '../../../../presentation/ui/primary_botton/primary_button_text.dart';
import 'dart:convert';

export 'user_dashboard_page.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({Key? key}) : super(key: key);

  @override
  _UserDashboardPageState createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  List<Map<String, dynamic>>? columns;

  @override
  void initState() {
    super.initState();
    _getUserColumns();
  }

  Future<void> _getUserColumns() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final currentUserJson = prefs.getString('currentUser') ?? '';
    Map<String, dynamic> currentUser =
        json.decode(currentUserJson) as Map<String, dynamic>;
    final currentUserId = currentUser['userId'];

    List<String>? columnsJsonList = prefs.getStringList('columns');

    List<Map<String, dynamic>> userColumns = [];
    if (columnsJsonList != null) {
      userColumns = columnsJsonList
          .map((columnJson) => json.decode(columnJson) as Map<String, dynamic>)
          .where((column) => column['userId'] == currentUserId)
          .toList();
    }

    setState(() {
      columns = userColumns;
    });
  }

  Future<void> dialogBuilder(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddColumnModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                width: 375,
                padding: EdgeInsets.fromLTRB(0, 8, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'My desk',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ),
                    SizedBox(height: 28),
                    Container(
                      width: 42,
                      height: 42,
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 60,
                          ),
                        ],
                      ),
                      child: ExitButton(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (columns != null && columns!.isNotEmpty)
            Positioned(
              top: 134,
              left: 24,
              right: 0,
              child: Container(
                height: 388,
                width: 375,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/background_image.png',
                      fit: BoxFit.cover,
                      width: 375,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...(columns
                                    ?.map((column) => [
                                          DeskCard(title: column['columnName']),
                                          SizedBox(height: 12),
                                        ])
                                    .expand((widget) => widget)
                                    .toList() ??
                                []),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (columns == null || columns!.isEmpty)
            Positioned(
              top: 341,
              left: 0,
              right: 0,
              child: Container(
                width: 258,
                height: 388,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/no_column_icon.png',
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "You haven't created any column",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Color(0xFF2A2A2A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (columns == null || columns!.isEmpty)
            Positioned(
              top: 593,
              left: 250,
              child: Image.asset(
                'assets/images/no_column_arrow.png',
                fit: BoxFit.cover,
              ),
            ),
          Positioned(
            bottom: 125,
            right: 20,
            child: Container(
              width: 65,
              height: 65,
              child: FloatingActionButton(
                onPressed: () => dialogBuilder(context),
                backgroundColor: Color(0xFF2A2A2A),
                elevation: 0,
                highlightElevation: 0,
                foregroundColor: Colors.white,
                splashColor: Colors.white,
                shape: CircleBorder(),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomTabBar(),
          ),
        ],
      ),
    );
  }
}

class DeskCard extends StatelessWidget {
  final String title;

  const DeskCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 311,
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xFF2A2A2A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
