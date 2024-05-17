import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../internal/application.dart';
import '../../../../presentation/ui/modals/change_modal.dart';
import '../../../../presentation/ui/bottons/exit_button.dart';
import '../widgets/desk_item.dart';
import '../widgets/no_content_block.dart';

class PageAllDesks extends StatefulWidget {
  const PageAllDesks({super.key});

  @override
  PageAllDesksState createState() => PageAllDesksState();
}

class PageAllDesksState extends State<PageAllDesks> {
  static const String backgroundImgPath = 'assets/images/background_image.png';
  static const String noDeskItemArrowImgPath =
      'assets/images/no_column_arrow.png';
  static const String noDeskItemImgPath = 'assets/images/no_column_icon.png';

  List<Map<String, dynamic>> get desks =>
      Provider.of<MyAppState>(context).getCurrentUserDesks();

  String get deskName {
    return Provider.of<MyAppState>(context, listen: false).currentDeskName;
  }

  String get deskColumnTitle {
    return '$deskName\'s columns desk';
  }

  Future<void> _dialogBuilderChangeModal(
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
    return Consumer<MyAppState>(
      builder: (context, myAppState, child) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints.expand(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight),
                    color: const Color(0xFFFCFCFC),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My desk',
                              style: TextStyle(
                                fontSize: constraints.maxHeight * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const ExitButton(),
                          ],
                        ),
                        SizedBox(height: constraints.maxHeight * 0.03),
                        if (desks.isNotEmpty)
                          Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  backgroundImgPath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: LimitedBox(
                                  maxHeight: constraints.maxHeight * 0.62,
                                  child: SizedBox(
                                    child: ListView.separated(
                                      itemCount: desks.length,
                                      separatorBuilder: (BuildContext context,
                                              int index) =>
                                          SizedBox(
                                              height:
                                                  constraints.maxHeight * 0.02),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final desk = desks[index];
                                        return DeskItem(
                                          desk: desk,
                                          onDismissed: (id) {
                                            myAppState.removeDesk(id);
                                          },
                                          onLongPress: (name, id) {
                                            _dialogBuilderChangeModal(
                                                context, name, id);
                                          },
                                          onTap: (id) {
                                            myAppState.setPageIndex(1);
                                            myAppState.setCurrentDeskId(id);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (desks.isEmpty)
                          const NoContentBlock(
                            noDeskItemImgPath: noDeskItemImgPath,
                            noDeskItemArrowImgPath: noDeskItemArrowImgPath,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
