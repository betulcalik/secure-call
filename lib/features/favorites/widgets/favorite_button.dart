import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:secure_call/features/favorites/bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';

class FavoriteButton extends StatefulWidget {
  final Contact contact;
  const FavoriteButton({super.key, required this.contact});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  void _toggleFavorite(String id) {
    BlocProvider.of<FavoritesBloc>(context).add(SetFavoriteContact(id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is LoadedFavoriteContacts) {
          return IconButton(
            icon: (
                state.contacts.any((contact) => contact.id == widget.contact.id)
                    ? Icon(
                  Icons.favorite,
                  color: Colors.red.shade300,
                )
                    : Icon(
                  Icons.favorite_border,
                  color: Colors.red.shade300,
                )
            ),
            onPressed: () => _toggleFavorite(widget.contact.id),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
