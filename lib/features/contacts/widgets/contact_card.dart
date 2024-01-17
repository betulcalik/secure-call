import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:secure_call/utils/custom_colors.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: contact.photo != null ? Image.memory(contact.photo!).image : null,
        ),
        title: Row(
          children: [
            Expanded(
                child: Text(contact.displayName)
            ),
            Ink(
              decoration: const ShapeDecoration(
                color: CustomColors.primaryColor,
                shape: CircleBorder()
              ),
              child: IconButton(
                icon: const Icon(
                    Icons.call,
                    color: Colors.white),
                onPressed: () {
                  // Call action here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
