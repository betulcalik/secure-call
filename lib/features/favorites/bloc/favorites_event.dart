abstract class FavoritesEvent {}

class LoadFavoriteContacts extends FavoritesEvent {}

class SetFavoriteContact extends FavoritesEvent {
  final String id;
  SetFavoriteContact(this.id);
}

class SearchFavoriteContacts extends FavoritesEvent {
  final String searchTerm;
  SearchFavoriteContacts(this.searchTerm);
}
