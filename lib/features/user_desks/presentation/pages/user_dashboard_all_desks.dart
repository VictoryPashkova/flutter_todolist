import 'package:flutter/material.dart';
import 'package:flutter_todolist/presentation/ui/primary_botton/exit_button.dart';
import 'package:provider/provider.dart';
import '../../../../internal/application.dart';
import '../../../../presentation/ui/modals/add_modal.dart';
import '../../../../presentation/ui/desk_card/desk_item.dart';
import '../../../../presentation/ui/tab_bar/tab_bar_desk.dart';

export 'user_dashboard_all_desks.dart';

class UserDashboardAllDesksPage extends StatefulWidget {
  const UserDashboardAllDesksPage({Key? key}) : super(key: key);

  @override
  UserDashboardAllDesksPageState createState() =>
      UserDashboardAllDesksPageState();
}

class UserDashboardAllDesksPageState extends State<UserDashboardAllDesksPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _dialogBuilder(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, myAppState, _) {
        String userName = myAppState.currentUserName;
        String deskTitle = '$userName\'s all desks';
        List<Map<String, dynamic>> desks = myAppState.getCurrentUserDesks();
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
                            deskTitle,
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
              if (desks.isNotEmpty)
                Positioned(
                  top: 134,
                  left: 24,
                  right: 0,
                  child: SizedBox(
                    height: 388,
                    width: 375,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/background_image.png',
                          fit: BoxFit.cover,
                          width: 375,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 16),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ...(desks
                                    .map((desk) => [
                                          DeskItem(
                                              id: desk['id'],
                                              itemName: desk['name']),
                                          SizedBox(height: 12),
                                        ])
                                    .expand((widget) => widget)
                                    .toList()),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              if (desks.isEmpty)
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
                          "You haven't created any desk yet",
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
              if (desks.isEmpty)
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
                child: SizedBox(
                  width: 65,
                  height: 65,
                  child: FloatingActionButton(
                    onPressed: () => _dialogBuilder(context),
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
                child: TabBarDesk(),
              ),
            ],
          ),
        );
      },
    );
  }
}
