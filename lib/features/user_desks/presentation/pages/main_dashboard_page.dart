import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../internal/application.dart';
import '../../../../presentation/ui/modals/add_modal.dart';
import 'page_all_desks.dart';
import 'page_desk_columns.dart';
import 'page_followed.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({Key? key}) : super(key: key);

  @override
  UserDashboardPageState createState() => UserDashboardPageState();
}

class UserDashboardPageState extends State<UserDashboardPage> {
  Future<void> _dialogBuilder(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AddModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, myAppState, child) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: IndexedStack(
                        index: myAppState.currentPageIndex,
                        children: const [
                          PageAllDesks(),
                          // Child 2
                          PageADeskColumns(),
                          // Child 3
                          PageFollowed(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BottomNavigationBar(
              currentIndex: myAppState.currentPageIndex,
              onTap: (int newIndex) => {myAppState.setPageIndex(newIndex)},
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.my_library_add_rounded),
                  label: 'All Desks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.desktop_mac),
                  label: 'Current desk',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.group),
                  label: 'Followed',
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _dialogBuilder(context),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
