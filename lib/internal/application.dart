import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../presentation/home.dart';
import '../themes/bottom_navigation_bar_theme.dart';
import '../themes/dialog_theme.dart';
import '../themes/elevated_button_theme.dart';
import '../themes/floating_action_button_theme.dart';
import '../themes/input_decoration_theme.dart';
import 'dart:convert';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          fontFamily: 'Outfit',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: AppInputDecorationTheme.defaultTheme,
          dialogTheme: AppDialogTheme.defaultTheme,
          elevatedButtonTheme: AppElevatedButtonTheme.defaultTheme,
          floatingActionButtonTheme:
              AppFloatingActionButtonTheme.defaultTheme,
          bottomNavigationBarTheme:
              AppBottomNavigationBarTheme.defaultTheme,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<Map<String, dynamic>> _columns = [];
  List<Map<String, dynamic>> get columns => _columns;
  List<Map<String, dynamic>> _desks = [];
  List<Map<String, dynamic>> get desks => _desks;
  final List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> get users => _users;

  int currentUserId = 1;
  int currentPageIndex = 0;
  int currentDeskId = 1;
  String currentDeskName = '';
  String currentUserName = '';

  MyAppState() {
    _loadColumnsFromSharedPreferences();
    _loadDesksFromSharedPreferences();
  }

  Future<void> _loadColumnsFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      List<String> columnsJsonList = prefs.getStringList('columns') ?? [];
      _columns = columnsJsonList
          .map((columnJson) => json.decode(columnJson) as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error loading columns from SharedPreferences: $e');
    }
    notifyListeners();
  }

  Future<void> _loadDesksFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      List<String> desksJsonList = prefs.getStringList('desks') ?? [];
      _desks = desksJsonList
          .map((deskJson) => json.decode(deskJson) as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error loading desks from SharedPreferences: $e');
    }
    notifyListeners();
  }

  void getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final currentUserJson = prefs.getString('currentUser') ?? '{}';
      Map<String, dynamic> currentUser =
          json.decode(currentUserJson) as Map<String, dynamic>;
      currentUserId = currentUser['userId'] as int;
      currentUserName = currentUser['userName'] as String;
    } catch (e) {
      print('Error getting current user: $e');
    }
  }

  Future<void> addColumn(String name, int id, int deskId) async {
    getCurrentUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      _columns.add({
        'id': id,
        'name': name,
        'deskId': deskId,
      });
      notifyListeners();

      List<String> updatedColumnsJsonList =
          _columns.map((column) => json.encode(column)).toList();

      await prefs.setStringList('columns', updatedColumnsJsonList);
    } catch (e) {
      print('Error adding column: $e');
    }
  }

  List<Map<String, dynamic>> getCurrentDeskColumns() {
    getCurrentUser();
    List<Map<String, dynamic>> userColumns = [];
    for (var column in _columns) {
      if (column['deskId'] == currentDeskId) {
        userColumns.add(column);
      }
    }
    return userColumns;
  }

  Future<void> changeColumnTitle(String newColumnName, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      for (int i = 0; i < _columns.length; i++) {
        if (_columns[i]['id'] == id) {
          _columns[i]['name'] = newColumnName;
          break;
        }
      }

      List<String> updatedColumnsJsonList =
          _columns.map((column) => json.encode(column)).toList();
      await prefs.setStringList('columns', updatedColumnsJsonList);

      notifyListeners();
    } catch (e) {
      print('Error changing column title: $e');
    }
  }

  Future<void> removeColumn(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      _columns.removeWhere((column) => column['id'] == id);

      List<String> updatedColumnsJsonList =
          _columns.map((column) => json.encode(column)).toList();

      await prefs.setStringList('columns', updatedColumnsJsonList);
      notifyListeners();
    } catch (e) {
      print('Error removing column: $e');
    }
  }

  List<Map<String, dynamic>> getCurrentUserDesks() {
    getCurrentUser();
    List<Map<String, dynamic>> userDesks = [];
    for (var desk in _desks) {
      if (desk['userId'] == currentUserId) {
        userDesks.add(desk);
      }
    }
    return userDesks;
  }

  Future<void> addDesk(String name, int id) async {
    getCurrentUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      _desks.add({
        'id': id,
        'name': name,
        'userId': currentUserId,
      });
      notifyListeners();

      List<String> updatedDesksJsonList =
          _desks.map((desk) => json.encode(desk)).toList();

      await prefs.setStringList('desks', updatedDesksJsonList);
    } catch (e) {
      print('Error adding desk: $e');
    }
  }

  Future<void> changeDeskTitle(String newDeskName, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      for (int i = 0; i < _desks.length; i++) {
        if (_desks[i]['id'] == id) {
          _desks[i]['name'] = newDeskName;
          break;
        }
      }

      List<String> updatedDesksJsonList =
          _desks.map((desk) => json.encode(desk)).toList();
      await prefs.setStringList('desks', updatedDesksJsonList);

      notifyListeners();
    } catch (e) {
      print('Error changing desk title: $e');
    }
  }

  Future<void> removeDesk(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      _columns.removeWhere((column) => column['deskId'] == id);
      List<String> updatedColumnsJsonList =
          _columns.map((column) => json.encode(column)).toList();
      await prefs.setStringList('columns', updatedColumnsJsonList);

      _desks.removeWhere((desk) => desk['id'] == id);

      List<String> updatedDesksJsonList =
          _desks.map((desk) => json.encode(desk)).toList();

      await prefs.setStringList('desks', updatedDesksJsonList);
      notifyListeners();
    } catch (e) {
      print('Error removing desk: $e');
    }
  }

  Future<void> setPageIndex(int index) async {
    currentPageIndex = index;
    notifyListeners();
  }

  Future<void> setCurrentDeskId(int id) async {
    currentDeskId = id;
    setCurrentDeskName();
    notifyListeners();
  }

  Future<void> setCurrentDeskName() async {
    final Map<String, dynamic> desk = _desks
        .firstWhere((desk) => desk['id'] == currentDeskId, orElse: () => {});
    try {
      if (desk.isNotEmpty) {
        currentDeskName = desk['name'] as String;
      } else {
        currentDeskName = '';
      }
    } catch (e) {
      print('Error setting current desk name: $e');
    }

    notifyListeners();
  }
}
