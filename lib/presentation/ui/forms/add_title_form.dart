import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../presentation/ui/primary_botton/primary_button_text.dart';
import '../../../../internal/application.dart';

export 'add_title_form.dart';

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

  @override
  Widget build(BuildContext context) {
    MyAppState myAppState = Provider.of<MyAppState>(context);
    int currentPageIndex = myAppState.currentPageIndex;
    String hintText = currentPageIndex == 1
        ? 'Enter desk name'
        : currentPageIndex == 2
            ? 'Enter column name'
            : '';

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _textFieldController,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2A2A2A), width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCFCFCF), width: 1.0),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC2534C), width: 1.0),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC2534C), width: 1.0),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Color(0xFFCFCFCF),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
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
          SizedBox(height: 42),
          ElevatedButton(
            onPressed: _isFormValid
                ? () {
                    if (currentPageIndex == 1) {
                      _addDesk(context);
                      Navigator.of(context).pop();
                    } else if (currentPageIndex == 2) {
                      _addColumn(context);
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.fromLTRB(12, 16, 12, 16)),
              minimumSize: MaterialStateProperty.all(Size(375, 54)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) {
                  return const Color(0xFFEBEBEB);
                }
                return const Color(0xFF2A2A2A);
              }),
            ),
            child: PrimaryButtonText(text: 'Add'),
          ),
        ],
      ),
    );
  }
}
