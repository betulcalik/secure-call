
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteButton extends StatefulWidget {
  final Contact contact;
  const FavoriteButton({super.key, required this.contact});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  Map<String, bool> _favorites = {};

  @override
  void initState() {
      super.initState();
      _loadFavorites();
  }

  Future<void> _loadFavorites() async {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString("favorite_contact");

      if (jsonString != null) {
        setState(() {
            _favorites = Map<String, bool>.from(json.decode(jsonString));
        });
      }
  }

  Future<void> _toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _favorites[id] = !(_favorites[id] ?? false);
      prefs.setString("favorite_contact", json.encode(_favorites));
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: (
          _favorites[widget.contact.id] == true
          ? Icon(
            Icons.favorite,
            color: Colors.red.shade300)
          : Icon(
            Icons.favorite_border,
            color: Colors.red.shade300,
            )
      ),
      onPressed: () => _toggleFavorite(widget.contact.id),
    );
  }
}
