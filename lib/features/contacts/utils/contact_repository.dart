import 'package:flutter_contacts/flutter_contacts.dart';

class ContactRepository {
  Future<List<Contact>> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      return FlutterContacts.getContacts(withPhoto: true);
    } else {
      throw Exception('Permission denied');
    }
  }
}