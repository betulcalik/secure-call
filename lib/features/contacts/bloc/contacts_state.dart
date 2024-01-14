import 'package:flutter_contacts/contact.dart';

abstract class ContactsState {}

class LoadingContacts extends ContactsState {}

class LoadedContacts extends ContactsState {
  final List<Contact> contacts;

  LoadedContacts(this.contacts);
}
