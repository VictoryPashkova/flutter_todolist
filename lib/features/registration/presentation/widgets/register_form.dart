import 'package:flutter/material.dart';
import 'package:flutter_todolist/features/log_in/presentation/pages/log_in_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_style/dart_style.dart';
import '../../../../presentation/ui/primary_botton/primary_button_text.dart';
import '../pages/registration_success_page.dart';
import '../../../log_in/presentation/pages/log_in_page.dart';
import '../pages/registration_main_page.dart';
import 'dart:convert';

export 'register_form.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool isEmailValid = false;
  Color inputTextColor = Color(0xFF2A2A2A);
  Color validInputColor = Color(0xFF39C622);
  Color inputBorderColor = Color(0xFFCFCFCF);
  bool isConfirmPassValid = false;
  Color obscureIconColor = Color(0xFF2A2A2A);
  bool isPassValid = false;
  Color focusedBorderColor = Color(0xFF2A2A2A);
  Color enabledBorderColor = Color(0xFFCFCFCF);
  Color errorBorderColor = Color(0xFFC2534C);

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isFormValid = true;
      });
    } else {
      setState(() {
        _isFormValid = false;
      });
    }
  }

  void _registerUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> user = {
      'userId': DateTime.now().millisecondsSinceEpoch,
      'userName': _nameController.text,
      'userEmail': _emailController.text,
      'userPassword': _pass.text,
    };

    // Получение списка строк из SharedPreferences
    List<String>? usersJsonList = prefs.getStringList('users');

    // Создание списка пользователей типа List<Map<String, dynamic>>
    List<Map<String, dynamic>> users = [];
    if (usersJsonList != null) {
      // Преобразование каждой строки JSON-представления пользователя в объект Map
      users = usersJsonList
          .map((userJson) => json.decode(userJson) as Map<String, dynamic>)
          .toList();
    }

    // Добавление нового пользователя в список
    users.add(user);

    // Преобразование списка пользователей в список JSON-строк
    List<String> updatedUsersJsonList =
        users.map((user) => json.encode(user)).toList();

    // Сохранение списка JSON-строк в SharedPreferences
    await prefs.setStringList('users', updatedUsersJsonList);
    print(prefs.getStringList('users'));

    _nameController.clear();
    _emailController.clear();
    _pass.clear();
    _confirmPass.clear();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationSuccessScreen()),
    );
  }

  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscurePassword = !_isObscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isObscureConfirmPassword = !_isObscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String? value) {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }

      return !regex.hasMatch(value) ? 'Enter correct e-mail' : null;
    }

    String? validateConfirmPass(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      if (value.length < 5 && value == _pass.text) {
        return 'Password field must be at least 5 characters';
      }
      if (value != _pass.text) {
        return 'Passwords must match';
      }
      return null;
    }

    String? validatePass(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter password';
      }
      if (value.length < 5) {
        return 'Password must be at least 5 characters';
      }
      return null;
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
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
              hintText: 'Enter your first name',
              hintStyle: TextStyle(
                color: Color(0xFFCFCFCF),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              labelText: 'Name',
              labelStyle: TextStyle(
                color: Color(0xFF696969),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            onChanged: (value) => _validateForm(),
          ),
          SizedBox(height: 28),
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
              _validateForm();
              setState(() {
                isEmailValid = validateEmail(value) == null;
                if (isEmailValid && value.isNotEmpty) {
                  focusedBorderColor = validInputColor;
                  enabledBorderColor = validInputColor;
                } else if (!isEmailValid && value.isNotEmpty) {
                  focusedBorderColor = errorBorderColor;
                  enabledBorderColor = errorBorderColor;
                } else {
                  focusedBorderColor = inputTextColor;
                  enabledBorderColor = inputBorderColor;
                }
              });
            },
          ),
          SizedBox(height: 28),
          TextFormField(
            controller: _pass,
            style: TextStyle(
              color: isPassValid ? validInputColor : Color(0xFFC2534C),
            ),
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
              suffixIcon: !isConfirmPassValid
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
            validator: validatePass,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              _validateForm();
              setState(() {
                isPassValid = validatePass(value) == null;
                if (isPassValid && value.isNotEmpty) {
                  focusedBorderColor = validInputColor;
                  enabledBorderColor = validInputColor;
                } else if (!isPassValid && value.isNotEmpty) {
                  focusedBorderColor = errorBorderColor;
                  enabledBorderColor = errorBorderColor;
                } else {
                  focusedBorderColor = inputTextColor;
                  enabledBorderColor = inputBorderColor;
                }
              });
            },
          ),
          SizedBox(height: 28),
          TextFormField(
            style: TextStyle(
              color: isConfirmPassValid ? validInputColor : Color(0xFFC2534C),
            ),
            controller: _confirmPass,
            obscureText: _isObscureConfirmPassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              constraints: BoxConstraints(
                minHeight: 68,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 12),
              hintText: 'Enter your password again',
              hintStyle: TextStyle(
                color: isConfirmPassValid ? validInputColor : inputBorderColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              labelText: 'Confirm password',
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
              suffixIcon: !isConfirmPassValid
                  ? IconButton(
                      onPressed: _toggleConfirmPasswordVisibility,
                      icon: Icon(
                        _isObscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _isObscureConfirmPassword
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    )
                  : Icon(
                      Icons.check,
                      color: validInputColor,
                    ),
            ),
            validator: validateConfirmPass,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              _validateForm();
              setState(() {
                isConfirmPassValid = validateConfirmPass(value) == null;
                if (isConfirmPassValid && value.isNotEmpty) {
                  focusedBorderColor = validInputColor;
                  enabledBorderColor = validInputColor;
                } else if (!isConfirmPassValid && value.isNotEmpty) {
                  focusedBorderColor = errorBorderColor;
                  enabledBorderColor = errorBorderColor;
                } else {
                  focusedBorderColor = inputTextColor;
                  enabledBorderColor = inputBorderColor;
                }
              });
            },
          ),
          SizedBox(height: 42),
          ElevatedButton(
            onPressed: _isFormValid
                ? () {
                    _registerUser();
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
            child: PrimaryButtonText(text: 'Register'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
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
                    MaterialPageRoute(builder: (context) => LogInMainPage()),
                  );
                },
                child: Text(
                  'Log in',
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
