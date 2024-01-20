import 'package:flutter_contacts/contact.dart';

abstract class FavoritesState {}

class LoadingFavoriteContacts extends FavoritesState {}
class LoadedFavoriteContacts extends FavoritesState {
  final List<Contact> contacts;
  LoadedFavoriteContacts(this.contacts);
}
