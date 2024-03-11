abstract class ContactsEvent {}

class LoadContacts extends ContactsEvent {}

class SearchContacts extends ContactsEvent {
  final String searchTerm;
  SearchContacts(this.searchTerm);
}
