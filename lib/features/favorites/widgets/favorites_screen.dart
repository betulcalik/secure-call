import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/contacts/constants/contact_card_icon_type.dart';
import '../../contacts/widgets/contact_card.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is LoadedFavoriteContacts) {
          if (state.contacts.isEmpty) {
            return const Center(child: Text("No favorite contacts found"));
          }
          return ListView.builder(
            itemCount: state.contacts.length,
            itemBuilder: (context, index) =>
              ContactCard(contact: state.contacts[index], iconType: ContactCardIconType.favorite),
          );
        } else {
          // Handle the case where the state is not LoadedFavoriteContacts
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
