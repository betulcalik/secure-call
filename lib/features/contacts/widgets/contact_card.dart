import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:secure_call/features/contacts/constants/contact_card_icon_type.dart';
import 'package:secure_call/widgets/buttons/favorite_button.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final ContactCardIconType iconType;
  const ContactCard({super.key, required this.contact, required this.iconType});

  Widget cardIcon() {
    switch (iconType) {
      case ContactCardIconType.call:
        return IconButton(
            icon: const Icon(
              Icons.call,
              color: Colors.green,
            ),
            onPressed: () {

            },
        );
      case ContactCardIconType.favorite:
        return FavoriteButton(contact: contact);
      case ContactCardIconType.noIcon:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: contact.photo != null ? CircleAvatar(
          backgroundImage: Image.memory(contact.photo!).image,
        ) : null,
        title: Row(
          children: [
            Expanded(
                child: Text(contact.displayName)
            ),
            Ink(
              decoration: const ShapeDecoration(
                shape: CircleBorder()
              ),
              child: cardIcon(),
              ),
          ],
        ),
      ),
    );
  }
}
