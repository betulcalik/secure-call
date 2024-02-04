import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/registration/bloc/registration_bloc.dart';
import 'package:secure_call/features/registration/bloc/registration_state.dart';
import 'package:secure_call/features/registration/models/register_model.dart';
import 'package:secure_call/features/registration/widgets/verify_phone_screen.dart';
import 'package:secure_call/widgets/forms/registration_form.dart';
import 'package:secure_call/widgets/popups/CustomPopup.dart';
import '../bloc/registration_event.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isValid = false;
  String _currentCountryCode = "";
  bool _isErrorPopupShown = false;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _updateValidity() {
    setState(() {
      // Check if name, phone number, password, and country code are valid
      _isValid = _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _passwordController.text.length >= 6 &&
          _currentCountryCode.isNotEmpty;
    });
  }

  void _register() {
    RegisterEvent event = RegisterEvent(
      model: RegisterModel(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        countryCode: _currentCountryCode,
        phone: _phoneController.text,
        password: _passwordController.text,
      ),
    );

    BlocProvider.of<RegistrationBloc>(context).add(event);
  }

  void _routeVerifyPhoneScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifyPhoneScreen(phone: _phoneController.text),
      ),
    );
  }

  void _routeLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
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
        if (state is RegisterSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _routeVerifyPhoneScreen();
          });
        } else if (state is RegisterFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showErrorPopup(context, state.message);
          });
        }
      },
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            viewInsets: MediaQuery.of(context).viewInsets.copyWith(bottom: 0),
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(Icons.call, size: 38),
                        const SizedBox(height: 20),
                        const Text(
                          "Enter your phone number\nto sign up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Source Sans 3",
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: RegistrationForm(
                            firstNameController: _firstNameController,
                            lastNameController: _lastNameController,
                            phoneController: _phoneController,
                            passwordController: _passwordController,
                            onTextChanged: _updateValidity,
                            onCountryCodeChanged: (newCountryCode) {
                              setState(() {
                                _currentCountryCode = newCountryCode;
                                _updateValidity();
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () => _routeLoginScreen(),
                                child: const Row(
                                  children: [
                                    Text("Already have an account?"),
                                    SizedBox(width: 4),
                                    Text(
                                      "Login.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: _isValid
                                ? () {
                                    _register();
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
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
