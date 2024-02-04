import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/registration/bloc/registration_event.dart';
import 'package:secure_call/features/registration/bloc/registration_state.dart';
import 'package:secure_call/features/registration/models/login_model.dart';
import 'package:secure_call/widgets/forms/login_form.dart';
import '../../../widgets/popups/CustomPopup.dart';
import '../../main/main_screen.dart';
import '../bloc/registration_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isValid = false;
  bool _isErrorPopupShown = false;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _updateValidity() {
    setState(() {
      // Check if name, phone number, password, and country code are valid
      _isValid = _phoneController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _passwordController.text.length >= 6;
    });
  }

  void _login() {
    LoginEvent event = LoginEvent(
        model: LoginModel(
          phone: _phoneController.text,
          password: _passwordController.text
        )
    );

    BlocProvider.of<RegistrationBloc>(context).add(event);
  }

  void _routeMainScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
    );
  }

  void _showErrorPopup(BuildContext context, String message) {
    if (_isErrorPopupShown) return;
    _isErrorPopupShown = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
            title: "Error",
            message: message
        );
      },
    ).then((_) {
      _isErrorPopupShown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              _routeMainScreen();
          });
        } else if (state is LoginFailure) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _showErrorPopup(context, state.message);
          });
        }
      },
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                '',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Source Sans 3",
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: LoginForm(
                            phoneController: _phoneController,
                            passwordController: _passwordController,
                            onTextChanged: _updateValidity,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: _isValid
                                ? () {
                                    _login();
                                  }
                                : null,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
