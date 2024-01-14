import 'package:flutter/material.dart';
import 'package:secure_call/features/contacts/bloc/contacts_bloc.dart';
import 'package:secure_call/features/contacts/bloc/contacts_event.dart';
import 'package:secure_call/features/contacts/utils/contact_repository.dart';
import 'package:secure_call/features/contacts/widgets/contacts_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ContactsBloc contactsBloc = ContactsBloc(ContactRepository())..add(LoadContacts());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<ContactsBloc>(
      create: (context) => contactsBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff45A19D)),
          fontFamily: 'Montserrat',
          useMaterial3: true,
        ),
        home: const ContactsScreen(),
      )
    );
  }
}
