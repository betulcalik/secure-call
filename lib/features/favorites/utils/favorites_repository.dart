import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../../contacts/utils/contact_repository.dart';

class FavoritesRepository {
  final ContactRepository _contactRepository;
  FavoritesRepository(this._contactRepository);

  Future<List<Contact>> getFavoriteContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("favorite_contact");

    if (jsonString != null) {
      final favorites = Map<String, bool>.from(json.decode(jsonString));
      final favoriteIds = favorites.entries.where((entry) => entry.value).map((entry) => entry.key).toList();

      if (favoriteIds.isNotEmpty) {
        final contacts = await _contactRepository.getContacts();
        final favoriteContacts = contacts.where((contact) => favoriteIds.contains(contact.id)).toList();
        return favoriteContacts;
      }
    }

    return [];
  }

  Future<void> setFavoriteContact(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString("favorite_contact");

    Map<String, bool> favorites = jsonString != null
        ? Map<String, bool>.from(json.decode(jsonString))
        : {};

    favorites[id] = !(favorites[id] ?? false);
    prefs.setString("favorite_contact", json.encode(favorites));
  }
}