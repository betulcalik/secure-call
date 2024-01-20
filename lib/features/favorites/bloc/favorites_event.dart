abstract class FavoritesEvent {}

class LoadFavoriteContacts extends FavoritesEvent {}

class SetFavoriteContact extends FavoritesEvent {
  final String id;
  SetFavoriteContact(this.id);
}