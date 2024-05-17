import 'package:flutter/material.dart';
import 'package:flutter_todolist/features/log_in/presentation/pages/log_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/registration_success_page.dart';
import '../../../../presentation/ui/bottons/primary_button.dart';
import 'dart:convert';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  static const Color errorColor = Color(0xFFC2534C);
  static const Color hightLightColor = Color(0xFFDE6352);
  static const Color enabledColor = Color(0xFFCFCFCF);
  static const Color focusedColor = Color(0xFF2A2A2A);
  static const Color succeededColor = Color(0xFF39C622);
  static const Color secondatyTextColor = Color(0xFF696969);
  static const Color enabledBtnColor = Color(0xFFEBEBEB);

  bool _isFormValid = false;
  bool _isEmailValid = false;
  bool _isPassValid = false;
  bool _isConfirmPassValid = false;

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

    List<String> usersJsonList = prefs.getStringList('users') ?? [];

    List<Map<String, dynamic>> users = [];
    users = usersJsonList
        .map((userJson) => json.decode(userJson) as Map<String, dynamic>)
        .toList();

    prefs.setString('currentUser', json.encode(user));

    users.add(user);

    List<String> updatedUsersJsonList =
        users.map((user) => json.encode(user)).toList();

    await prefs.setStringList('users', updatedUsersJsonList);

    _nameController.clear();
    _emailController.clear();
    _pass.clear();
    _confirmPass.clear();
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

  void _onPressed() {
    _registerUser();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegistrationSuccessScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Enter your first name',
              labelText: 'Name',
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
          const SizedBox(height: 28),
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
            onChanged: (value) {
              _validateForm();
              setState(() {
                _isEmailValid = validateEmail(value) == null;
              });
            },
          ),
          const SizedBox(height: 28),
          TextFormField(
            controller: _pass,
            style: TextStyle(
              color: _isPassValid ? succeededColor : errorColor,
            ),
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
            validator: validatePass,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              _validateForm();
              setState(() {
                _isPassValid = validatePass(value) == null;
              });
            },
          ),
          const SizedBox(height: 28),
          TextFormField(
            style: TextStyle(
              color: _isConfirmPassValid ? succeededColor : errorColor,
            ),
            controller: _confirmPass,
            obscureText: _isObscureConfirmPassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Enter your password again',
              labelText: 'Confirm password',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: _isConfirmPassValid ? succeededColor : focusedColor,
                    width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: _isConfirmPassValid ? succeededColor : enabledColor,
                    width: 1.0),
              ),
              suffixIcon: !_isConfirmPassValid
                  ? IconButton(
                      onPressed: _toggleConfirmPasswordVisibility,
                      icon: Icon(
                        _isObscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _isObscureConfirmPassword
                            ? enabledColor
                            : focusedColor,
                      ),
                    )
                  : const Icon(
                      Icons.check,
                      color: succeededColor,
                    ),
            ),
            validator: validateConfirmPass,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              _validateForm();
              setState(() {
                _isConfirmPassValid = validateConfirmPass(value) == null;
              });
            },
          ),
          const SizedBox(height: 42),
          PrimaryButton(
            onPressed: () => _onPressed(),
            btnText: 'Register',
            isValid: _isFormValid,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account?',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: secondatyTextColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LogInMainPage(),
                    ),
                  );
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    fontFamily: 'Outfit',
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
