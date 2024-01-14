import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/contacts/bloc/contacts_event.dart';
import 'package:secure_call/features/contacts/bloc/contacts_state.dart';
import '../utils/contact_repository.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactRepository contactRepository;

  ContactsBloc(this.contactRepository) : super(LoadingContacts()) {
    on<LoadContacts>((event, emit) async {
      emit(LoadingContacts());
      try {
        final contacts = await contactRepository.getContacts();
        emit(LoadedContacts(contacts));
      } catch (_) {
        emit(LoadedContacts([]));
      }
    });
  }
}
