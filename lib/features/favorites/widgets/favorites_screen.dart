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
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(LoadFavoriteContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          height: 60,
          child: TextField(
            onChanged: (value) => context.read<FavoritesBloc>().add(SearchFavoriteContacts(value)),
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              hintText: "Search favorite contacts",
              prefixIcon: const Icon(Icons.search),
              isDense: true, // decrease height of textfield
            ),
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
                      ContactCard(contact: state.contacts[index], iconType: ContactCardIconType.favorite),
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