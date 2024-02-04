import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/registration/bloc/registration_state.dart';
import '../../../widgets/boxes/otp_box.dart';
import '../../../widgets/popups/CustomPopup.dart';
import '../../main/main_screen.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../models/verify_model.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String phone;
  const VerifyPhoneScreen({
    super.key,
    required this.phone,
  });

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  List<OTPBox> otpBoxes = [];
  String maskedNumber = "";
  bool _isErrorPopupShown = false;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    maskedNumber = "******${widget.phone.substring(widget.phone.length - 3)}";
    controllers = List.generate(4, (_) => TextEditingController()..addListener(() {
      setState(() {
        _generateOTPBoxes();
        _updateIsValid();
      });
    }));
    _generateOTPBoxes();
  }

  void _verify() {
    String code = _getCodeString();
    VerifyEvent event = VerifyEvent(
        model: VerifyModel(
            phone: widget.phone,
            code: code
        )
    );

    BlocProvider.of<RegistrationBloc>(context).add(event);
  }

  void _generateOTPBoxes() {
    otpBoxes = controllers.map((controller) => OTPBox(isFilled: controller.text.isNotEmpty, controller: controller)).toList();
  }

  void _updateIsValid() {
    _isValid = controllers.every((controller) => controller.text.isNotEmpty);
  }

  String _getCodeString() {
    return controllers.map((controller) => controller.text).join();
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
        if (state is VerifySuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _routeMainScreen();
          });
        } else if (state is VerifyFailure) {
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
                    "Verify Phone",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Source Sans 3",
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                      "Please enter the OTP sent on your phone\nnumber $maskedNumber via text message."
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < otpBoxes.length; i++) ...[
                              otpBoxes[i],
                              if (i != otpBoxes.length - 1) const SizedBox(width: 10), // Only add SizedBox if it's not the last box
                            ],
                          ],
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Didn't receive code?"),
                                SizedBox(width: 4),
                                Text(
                                  "Resend code.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _isValid
                              ? () { _verify(); } : null,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
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
