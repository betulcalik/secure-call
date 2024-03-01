import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../../contacts/utils/contact_repository.dart';

class CallsRepository {
  final ContactRepository _contactRepository;

  CallsRepository(this._contactRepository);

  Future<List<Contact>> getRecentCalls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? recentCallsJson = prefs.getStringList('recentCalls');

    if (recentCallsJson != null) {
      return recentCallsJson.map((json) => Contact.fromJson(jsonDecode(json))).toList();
    } else {
      return [];
    }
  }

  Future<void> addCall(String id) async {
    Contact? contact = await _contactRepository.getContactById(id);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? recentCallsJson = prefs.getStringList('recentCalls') ?? [];

    recentCallsJson.insert(0, jsonEncode(contact?.toJson()));

    // Limit the list to, for example, 20 recent calls
    recentCallsJson = recentCallsJson.take(20).toList();

    await prefs.setStringList('recentCalls', recentCallsJson);
  }
}