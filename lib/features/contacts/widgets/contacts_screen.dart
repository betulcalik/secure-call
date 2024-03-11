import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/contacts/bloc/contacts_bloc.dart';
import 'package:secure_call/features/contacts/bloc/contacts_state.dart';
import 'package:secure_call/features/contacts/widgets/contact_card.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:secure_call/widgets/textfields/search_textfield.dart';
import '../bloc/contacts_event.dart';
import '../constants/contact_card_icon_type.dart';

class ContactsScreen extends StatefulWidget {
  final ContactCardIconType iconType;
  const ContactsScreen({super.key, required this.iconType});

  @override
  State<StatefulWidget> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  loadContacts() {
    context.read<ContactsBloc>().add(LoadContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 60,
            child: SearchTextField(
              onChanged: (value) => context.read<ContactsBloc>().add(SearchContacts(value)),
              hintText: "Search contacts",
            ),
          ),
          Expanded(
            child: BlocBuilder<ContactsBloc, ContactsState>(
              builder: (context, state) {
                if (state is LoadingContacts) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedContacts) {

                  return ListView.builder(
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) =>
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                          child: ContactCard(contact: state.contacts[index], iconType: widget.iconType),
                        ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
    );
  }
}