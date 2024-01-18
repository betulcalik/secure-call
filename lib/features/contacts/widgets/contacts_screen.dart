import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/contacts/bloc/contacts_bloc.dart';
import 'package:secure_call/features/contacts/bloc/contacts_state.dart';
import 'package:secure_call/features/contacts/widgets/contact_card.dart';
import 'package:flutter_contacts/contact.dart';
import '../bloc/contacts_event.dart';
import '../constants/contact_card_icon_type.dart';

class ContactsScreen extends StatefulWidget {
  final ContactCardIconType iconType;
  const ContactsScreen({super.key, required this.iconType});

  @override
  State<StatefulWidget> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    context.read<ContactsBloc>().add(LoadContacts());
  }

  onSearch(String searchText) {
    setState(() {
      _filteredContacts = searchText.isEmpty
          ? _contacts
          : _contacts
          .where((contact) =>
          contact.displayName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 60,
            child: TextField(
              onChanged: (value) => onSearch(value),
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
                hintText: "Search contacts",
                prefixIcon: const Icon(Icons.search),
                isDense: true, // decrease height of textfield
              ),
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
                  if (_contacts.isEmpty) {
                    _contacts = state.contacts;
                    _filteredContacts = state.contacts;
                  }

                  return ListView.builder(
                    itemCount: _filteredContacts.length,
                    itemBuilder: (context, index) =>
                        ContactCard(contact: _filteredContacts[index], iconType: widget.iconType),
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