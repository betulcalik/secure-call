import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/contacts/constants/contact_card_icon_type.dart';
import 'package:secure_call/widgets/textfields/search_textfield.dart';
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
  void initState() {
    super.initState();
    loadFavoriteContacts();
  }

  loadFavoriteContacts() {
    context.read<FavoritesBloc>().add(LoadFavoriteContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          height: 60,
          child: SearchTextField(
            onChanged: (value) => context.read<FavoritesBloc>().add(SearchFavoriteContacts(value)),
            hintText: "Search favorite contacts",
          ),
        ),
        Expanded(
          child: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              if (state is LoadingFavoriteContacts) {
                return const CircularProgressIndicator();
              } else if (state is LoadedFavoriteContacts) {
                if (state.contacts.isEmpty) {
                  return const Center(child: Text("No favorite contacts found"));
                }

                return ListView.builder(
                  itemCount: state.contacts.length,
                  itemBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: ContactCard(contact: state.contacts[index], iconType: ContactCardIconType.favorite),
                      ),
                );
              } else {
                return Container();
              }
            },
          ),
        )
      ],
    );
  }
}