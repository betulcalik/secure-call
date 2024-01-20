import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/favorites/bloc/favorites_event.dart';
import 'package:secure_call/features/favorites/bloc/favorites_state.dart';
import 'package:secure_call/features/favorites/utils/favorites_repository.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository favoritesRepository;

  FavoritesBloc(this.favoritesRepository) : super(LoadingFavoriteContacts()) {
    on<LoadFavoriteContacts>((event, emit) async {
      emit(LoadingFavoriteContacts());
      try {
        final contacts = await favoritesRepository.getFavoriteContacts();
        emit(LoadedFavoriteContacts(contacts));
      } catch (_) {
        emit(LoadedFavoriteContacts([]));
      }
    });

    on<SetFavoriteContact>((event, emit) async {
      await favoritesRepository.setFavoriteContact(event.id);
      final contacts = await favoritesRepository.getFavoriteContacts();
      emit(LoadedFavoriteContacts(contacts));
    });
  }
}