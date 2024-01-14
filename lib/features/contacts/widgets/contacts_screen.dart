import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/contacts/bloc/contacts_bloc.dart';
import 'package:secure_call/features/contacts/bloc/contacts_state.dart';
import 'package:secure_call/features/contacts/widgets/contact_card.dart';
import 'package:secure_call/utils/custom_colors.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contacts',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Source Sans 3',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: CustomColors.secondaryColor,
      ),
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          if (state is LoadingContacts) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedContacts) {
            if (state.contacts.isEmpty) {
              return const Center(
                child: Text('No contacts found.'),
              );
            } else {
              return ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) => ContactCard(contact: state.contacts[index]),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
