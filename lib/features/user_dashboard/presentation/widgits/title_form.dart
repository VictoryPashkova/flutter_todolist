import 'package:flutter/material.dart';
import 'package:flutter_todolist/presentation/ui/primary_botton/exit_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_style/dart_style.dart';
import '../../../../presentation/ui/primary_botton/primary_button_text.dart';
import 'dart:convert';

export 'title_form.dart';

class DeskForm extends StatefulWidget {
  const DeskForm({super.key});

  @override
  DeskFormState createState() {
    return DeskFormState();
  }
}

class DeskFormState extends State<DeskForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textFieldController = TextEditingController();
  bool _isFormValid = false;

  void _AddColumn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentUserJson = prefs.getString('currentUser') ?? '';

    Map<String, dynamic> currentUser =
        json.decode(currentUserJson) as Map<String, dynamic>;
    final currentUserId = currentUser['userId'];

    Map<String, dynamic> column = {
      'columnId': DateTime.now().millisecondsSinceEpoch,
      'columnName': _textFieldController.text,
      'userId': currentUserId,
    };

    List<String>? columnsJsonList = prefs.getStringList('columns');

    List<Map<String, dynamic>> columns = [];
    if (columnsJsonList != null) {
      columns = columnsJsonList
          .map((columnJson) => json.decode(columnJson) as Map<String, dynamic>)
          .toList();
    }

    columns.add(column);

    List<String> updatedColumnsJsonList =
        columns.map((column) => json.encode(column)).toList();

    // Сохранение списка JSON-строк в SharedPreferences
    await prefs.setStringList('columns', updatedColumnsJsonList);
    print(prefs.getStringList('columns'));

    _textFieldController.clear();
    Navigator.of(context).pop();
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
              hintText: 'Enter titile of column',
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
                    _AddColumn();
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
