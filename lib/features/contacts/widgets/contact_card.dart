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
        title: Text(contact.displayName),
      ),
    );
  }
}
