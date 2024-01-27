import 'package:flutter/material.dart';

import '../../../widgets/boxes/otp_box.dart';

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
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    maskedNumber = "******${widget.phone.substring(widget.phone.length - 3)}";
    controllers = List.generate(4, (_) => TextEditingController()..addListener(() {
      setState(() {
        _generateOTPBoxes();
      });
    }));
    _generateOTPBoxes();
  }

  void _verify() {

  }

  void _generateOTPBoxes() {
    otpBoxes = controllers.map((controller) => OTPBox(isFilled: controller.text.isNotEmpty, controller: controller)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verify Phone",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Source Sans 3",
                fontSize: 32,
              ),
            ),
            SizedBox(height: 10),
            Text(
                "Please enter the OTP sent on your phone\nnumber $maskedNumber via text messsage."
            ),
            SizedBox(height: 20),
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
                  SizedBox(height: 40),
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
                  SizedBox(height: 20),
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
  }
}
