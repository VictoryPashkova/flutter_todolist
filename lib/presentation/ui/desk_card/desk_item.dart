import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../internal/application.dart';
import '../../../presentation/ui/modals/change_modal.dart';
import '../../../features/user_dashboard/presentation/pages/user_dashboard_page.dart';

export 'desk_item.dart';

class DeskItem extends StatelessWidget {
  final int id;
  final String itemName;

  const DeskItem({Key? key, required this.id, required this.itemName})
      : super(key: key);

  Future<void> _dialogBuilder(
      BuildContext context, String itemName, int id) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ChangeModal(itemName: itemName, id: id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MyAppState myAppState = Provider.of<MyAppState>(context);
    int currentPageIndex = myAppState.currentPageIndex;

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Color(0xFFC2534C),
        ),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        if (currentPageIndex == 1) {
          myAppState.removeDesk(id);
        } else if (currentPageIndex == 2) {
          myAppState.removeColumn(id);
        }
      },
      child: GestureDetector(
        onLongPress: () => _dialogBuilder(context, itemName, id),
        onTap: () {
          if (currentPageIndex == 1) {
            myAppState.setPageIndex(2);
            myAppState.setCurrentDeskId(id);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UserDashboardPage(id: id, itemName: itemName)),
            );
          }
        },
        child: Container(
          width: 343,
          height: 76,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
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
