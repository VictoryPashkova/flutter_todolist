import 'package:flutter/material.dart';
import 'package:flutter_todolist/presentation/ui/bottons/primary_button.dart';
import 'package:provider/provider.dart';
import '../../../../internal/application.dart';

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  AddItemFormState createState() {
    return AddItemFormState();
  }
}

class AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textFieldController = TextEditingController();
  bool _isFormValid = false;
  static const Color enabledColor = Color(0xFFEBEBEB);

  void _addColumn(BuildContext context) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    final columnName = _textFieldController.text;

    final myAppState = Provider.of<MyAppState>(context, listen: false);
    final deskId = myAppState.currentDeskId;
    await myAppState.addColumn(columnName, id, deskId);

    _textFieldController.clear();
  }

  void _addDesk(BuildContext context) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    final deskName = _textFieldController.text;

    final myAppState = Provider.of<MyAppState>(context, listen: false);
    await myAppState.addDesk(deskName, id);

    _textFieldController.clear();
  }

  int _getCurrentPageIndex(BuildContext context) {
    MyAppState myAppState = Provider.of<MyAppState>(context, listen: false);
    int currentPageIndex = myAppState.currentPageIndex;
    return currentPageIndex;
  }

  void _onPressed() {
    if (_getCurrentPageIndex(context) == 0) {
      _addDesk(context);
      Navigator.of(context).pop();
    } else if (_getCurrentPageIndex(context) == 1) {
      _addColumn(context);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _textFieldController,
            decoration: const InputDecoration(
              hintText: 'Enter some name...',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  _isFormValid = true;
                });
              }
            },
          ),
          PrimaryButton(
            onPressed: () => _onPressed(),
            btnText: 'Add',
            isValid: _isFormValid,
          ),
        ],
      ),
    );
  }
}
