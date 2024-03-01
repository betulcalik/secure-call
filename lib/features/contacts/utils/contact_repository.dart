import 'package:flutter_contacts/flutter_contacts.dart';

class ContactRepository {

  Future<List<Contact>> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      return FlutterContacts.getContacts(withPhoto: true);
    } else {
      throw Exception('Permission denied');
    }
  }

  Future<Contact?> getContactById(String id) async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts = await FlutterContacts.getContacts(withPhoto: true);
      Contact? targetContact;

      for (Contact contact in contacts) {
        if (contact.id == id) {
          targetContact = contact;
          break;
        }
      }

      return targetContact;
    } else {
      throw Exception('Permission denied');
    }
  }
}