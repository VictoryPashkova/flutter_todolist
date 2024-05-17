import 'package:flutter/material.dart';
import 'package:flutter_todolist/features/registration/presentation/pages/registration_main_page.dart';
import 'package:flutter_todolist/features/user_desks/presentation/pages/main_dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../presentation/ui/bottons/primary_button.dart';
import 'dart:convert';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  LogInFormState createState() => LogInFormState();
}

class LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<LogInFormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isFormValid = false;
  bool _isEmailValid = false;
  bool _userFound = false;
  bool _emailUserFound = false;
  bool _passwordUserFound = false;
  bool _isPassValid = false;

  static const Color errorColor = Color(0xFFC2534C);
  static const Color hightLightColor = Color(0xFFDE6352);
  static const Color enabledColor = Color(0xFFCFCFCF);
  static const Color focusedColor = Color(0xFF2A2A2A);
  static const Color succeededColor = Color(0xFF39C622);
  static const Color secondatyTextColor = Color(0xFF696969);
  static const Color enabledBtnColor = Color(0xFFEBEBEB);

  void _validateForm() {
    if (_userFound) {
      _isFormValid = true;
    } else {
      _isFormValid = false;
    }
  }

  bool _isObscurePassword = true;

  void _togglePasswordVisibility() {
    _isObscurePassword = !_isObscurePassword;
  }

  void _loginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentUser', '');

    String userEmail = _emailController.text;
    String userPassword = _passwordController.text;

    _emailUserFound = false;
    _passwordUserFound = false;
    _userFound = false;
    Map<String, dynamic> currentUser = {};

    List<String> usersJsonList = prefs.getStringList('users') ?? [];
    List users =
        usersJsonList.map((userJson) => json.decode(userJson)).toList();
    for (var user in users) {
      if (user['userEmail'] == userEmail) {
        _emailUserFound = true;
      }
      if (user['userPassword'] == userPassword) {
        _passwordUserFound = true;
        currentUser = user;
      }
      if (_passwordUserFound && _emailUserFound) {
        _userFound = true;
        break;
      }
    }

    if (_userFound) {
      prefs.setString('currentUser', json.encode(currentUser));
    }

    setState(() {
      _validateForm();
    });
  }

  String? validateEmail(String? value) {
    _loginUser();
    if (!_emailUserFound) {
      _isEmailValid = false;
      return 'E-mail not found';
    } else if (_emailUserFound) {
      _isEmailValid = true;
    }
    return null;
  }

  String? validatePassword(String? value) {
    _loginUser();
    if (!_userFound) {
      _isPassValid = false;
      return 'User not found';
    } else if (!_passwordUserFound) {
      _isPassValid = false;
      return 'Wrong password';
    } else if (_passwordUserFound) {
      _isPassValid = true;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _emailController,
            style: TextStyle(
              color: _isEmailValid ? succeededColor : errorColor,
            ),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Enter your e-mail',
              labelText: 'E-mail',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: _isEmailValid ? succeededColor : focusedColor,
                    width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: _isEmailValid ? succeededColor : enabledColor,
                    width: 1.0),
              ),
              errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
              suffixIcon: _isEmailValid
                  ? const Icon(
                      Icons.check,
                      color: succeededColor,
                    )
                  : null,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
          SizedBox(height: screenHeight * 0.05),
          TextFormField(
            style: TextStyle(
              color: _isPassValid ? succeededColor : errorColor,
            ),
            controller: _passwordController,
            obscureText: _isObscurePassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              labelText: 'Password',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: _isPassValid ? succeededColor : focusedColor,
                    width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: _isPassValid ? succeededColor : enabledColor,
                    width: 1.0),
              ),
              suffixIcon: !_isPassValid
                  ? IconButton(
                      onPressed: _togglePasswordVisibility,
                      icon: Icon(
                        _isObscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _isObscurePassword ? enabledColor : focusedColor,
                      ),
                    )
                  : const Icon(
                      Icons.check,
                      color: succeededColor,
                    ),
            ),
            validator: validatePassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          SizedBox(height: screenHeight * 0.06),
          PrimaryButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserDashboardPage(),
                ),
              );
            },
            btnText: 'Confirm',
            isValid: _isFormValid,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don’t have an account?',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: secondatyTextColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RegistrationMainPage(),
                    ),
                  );
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: hightLightColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
