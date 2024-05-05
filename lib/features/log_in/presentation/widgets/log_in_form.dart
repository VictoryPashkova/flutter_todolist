import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../presentation/ui/primary_botton/primary_button_text.dart';
import '../../../registration/presentation/pages/registration_main_page.dart';
import 'dart:convert';
import '../../../user_desks/presentation/pages/user_dashboard_all_desks.dart';

export 'log_in_form.dart';

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
  bool isEmailValid = false;
  bool userFound = false;
  bool emailUserFound = false;
  bool passwordUserFound = false;
  bool isPassValid = false;

  Color inputTextColor = Color(0xFF2A2A2A);
  Color validInputColor = Color(0xFF39C622);
  Color inputBorderColor = Color(0xFFCFCFCF);
  Color obscureIconColor = Color(0xFF2A2A2A);
  Color focusedBorderColor = Color(0xFF2A2A2A);
  Color enabledBorderColor = Color(0xFFCFCFCF);
  Color errorBorderColor = Color(0xFFC2534C);

  void _validateForm() {
    if (userFound) {
      setState(() {
        _isFormValid = true;
      });
    } else {
      setState(() {
        _isFormValid = false;
      });
    }
  }

  bool _isObscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscurePassword = !_isObscurePassword;
    });
  }

  void _loginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentUser', '');

    String userEmail = _emailController.text;
    String userPassword = _passwordController.text;

    emailUserFound = false;
    passwordUserFound = false;
    userFound = false;
    Map<String, dynamic> currentUser = {};

    List<String> usersJsonList = prefs.getStringList('users') ?? [];
    List users =
        usersJsonList.map((userJson) => json.decode(userJson)).toList();
    for (var user in users) {
      if (user['userEmail'] == userEmail) {
        emailUserFound = true;
      }
      if (user['userPassword'] == userPassword) {
        passwordUserFound = true;
        currentUser = user;
      }
      if (passwordUserFound && emailUserFound) {
        userFound = true;
        break;
      }
    }

    if (userFound) {
      prefs.setString('currentUser', json.encode(currentUser));
    }

    setState(() {
      _validateForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String? value) {
      _loginUser();
      if (!emailUserFound) {
        isEmailValid = false;
        return 'E-mail not found';
      } else if (emailUserFound) {
        isEmailValid = true;
      }
      return null;
    }

    String? validatePassword(String? value) {
      _loginUser();
      if (!userFound) {
        isPassValid = false;
        return 'User not found';
      } else if (!passwordUserFound) {
        isPassValid = false;
        return 'Wrong password';
      } else if (passwordUserFound) {
        isPassValid = true;
      }
      return null;
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _emailController,
            style: TextStyle(
              color: isEmailValid ? validInputColor : Color(0xFFC2534C),
            ),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              constraints: BoxConstraints(
                minHeight: 68,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              hintText: 'Enter your e-mail',
              hintStyle: TextStyle(
                color: isEmailValid ? validInputColor : inputBorderColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              labelText: 'E-mail',
              labelStyle: TextStyle(
                color: Color(0xFF696969),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: focusedBorderColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: enabledBorderColor, width: 1.0),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: validInputColor, width: 1.0)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: errorBorderColor, width: 1.0)),
              suffixIcon: isEmailValid
                  ? Icon(
                      Icons.check,
                      color: validInputColor,
                    )
                  : null,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            onChanged: (value) {
              validateEmail(value);
            },
          ),
          SizedBox(height: 28),
          TextFormField(
            style: TextStyle(
              color: isPassValid ? validInputColor : Color(0xFFC2534C),
            ),
            controller: _passwordController,
            obscureText: _isObscurePassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              constraints: BoxConstraints(
                minHeight: 68,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              hintText: 'Enter your password',
              hintStyle: TextStyle(
                color: Color(0xFFCFCFCF),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              labelText: 'Password',
              labelStyle: TextStyle(
                color: Color(0xFF696969),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: focusedBorderColor, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: enabledBorderColor, width: 1.0),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF39C622), width: 1.0)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: errorBorderColor, width: 1.0)),
              suffixIcon: !isPassValid
                  ? IconButton(
                      onPressed: _togglePasswordVisibility,
                      icon: Icon(
                        _isObscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color:
                            _isObscurePassword ? Colors.grey : Colors.black87,
                      ),
                    )
                  : Icon(
                      Icons.check,
                      color: validInputColor,
                    ),
            ),
            validator: validatePassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              validatePassword(value);
            },
          ),
          SizedBox(height: 42),
          ElevatedButton(
            onPressed: _isFormValid
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserDashboardAllDesksPage()),
                    );
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
            child: PrimaryButtonText(text: 'Confirm'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don’t have an account?',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xFF696969),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationMainPage()),
                  );
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFFDE6352),
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
