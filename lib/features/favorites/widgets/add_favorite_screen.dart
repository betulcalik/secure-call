import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/contacts/constants/contact_card_icon_type.dart';
import 'package:secure_call/features/contacts/widgets/contacts_screen.dart';
import '../bloc/favorites_bloc.dart';

class AddFavoriteScreen extends StatefulWidget {
  const AddFavoriteScreen({super.key});

  @override
  State<AddFavoriteScreen> createState() => _AddFavoriteScreenState();
}

class _AddFavoriteScreenState extends State<AddFavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return const ContactsScreen(iconType: ContactCardIconType.favorite);
  }
}
