import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:secure_call/features/registration/widgets/register_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Introducing Secure Call",
      body: "Welcome to Secure Call, your go-to app for secure and convenient calling. Easily mark your favorite contacts for quick access and streamlined communication.",
      image: SizedBox(
        height: 180,
        child: Lottie.network(
            'https://lottie.host/a114cbf2-4d83-4249-9476-6dc524c93afa/ey3dqMGHVi.json'),
      ),
    ),
    PageViewModel(
      title: "Effortless Contact Management",
      body:
      "Explore all your contacts effortlessly with our user-friendly interface, ensuring you have every connection at your fingertips.",
      image: SizedBox(
        height: 180,
        child: Lottie.network(
            'https://lottie.host/33af5e56-29b7-4794-98e4-f135141b181d/6cZ6AYT86Z.json'),
      ),
    ),
    PageViewModel(
      title: "Crystal-Clear WiFi Calls",
      body:
      "Enjoy crystal-clear calls anytime, anywhere, using our advanced WiFi calling feature for a seamless and secure communication experience.",
      image: SizedBox(
        height: 180,
        child: Lottie.network(
            'https://lottie.host/0f3fc202-a4d6-4b1d-ba5e-a14b893c03c0/Xi56VvLKtr.json'),
      ),
    ),
  ];

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      showSkipButton: true,
      next: const Text("Next"),
      skip: const Text("Skip"),
      done: const Text("Done"),
      onDone: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      },
    );
  }
}
