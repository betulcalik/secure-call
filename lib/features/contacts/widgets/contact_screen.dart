import 'package:flutter/material.dart';
import 'package:secure_call/utils/custom_colors.dart';

import '../../../widgets/cards/outlined_card.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          width: 80,
          height: 80,
          child: CircleAvatar(
            backgroundColor: CustomColors.secondaryColor,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Betül Çalık",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              OutlinedCard(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text(
                    'E-mail',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text('betul.calik@example.com'),
                ),
              ),
              OutlinedCard(
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    'Phone',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text('+1 234 567 890'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
