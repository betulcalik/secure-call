import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import '../../../utils/custom_colors.dart';
import '../bloc/call_bloc.dart';
import '../bloc/call_event.dart';

class CallScreen extends StatelessWidget {
  final Contact contact;

  const CallScreen({super.key, required this.contact});

  void endCall() {
    // Implement the logic to end the call
  }

  @override
  Widget build(BuildContext context) {
    // Check if the contact has a photo
    bool hasPhoto = contact.photo != null && contact.photo!.isNotEmpty;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          if (hasPhoto)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(contact.photo!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (!hasPhoto) Container(color: CustomColors.secondaryColor),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 46),
                child: Text(
                  contact.displayName,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 46),
                  child: ElevatedButton(
                    onPressed: () => endCall(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Background color
                      shape: const CircleBorder(), // Make it circular
                      padding:
                          const EdgeInsets.all(20), // Adjust padding as needed
                    ),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                    ),
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
