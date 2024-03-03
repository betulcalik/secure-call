import 'package:flutter/material.dart';

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
          child: CircleAvatar(),
        ),
        SizedBox(height: 10),
        Text(
          "Betül Çalık",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: ListTile(
            leading: Icon(Icons.email),
            title: Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('betul.calik@example.com'),
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
    );
  }
}
