import 'package:flutter/material.dart';
import 'package:secure_call/features/contacts/bloc/contacts_bloc.dart';
import 'package:secure_call/features/contacts/bloc/contacts_event.dart';
import 'package:secure_call/features/contacts/utils/contact_repository.dart';
import 'package:provider/provider.dart';
import 'package:secure_call/features/favorites/bloc/favorites_event.dart';
import 'package:secure_call/features/registration/widgets/onboarding_screen.dart';
import 'package:secure_call/utils/custom_colors.dart';
import 'features/favorites/bloc/favorites_bloc.dart';
import 'features/favorites/utils/favorites_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ContactsBloc contactsBloc = ContactsBloc(ContactRepository())..add(LoadContacts());
  final FavoritesBloc favoritesBloc = FavoritesBloc(FavoritesRepository(ContactRepository()))..add(LoadFavoriteContacts());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ContactsBloc>(create: (context) => contactsBloc),
        Provider<FavoritesBloc>(create: (context) => favoritesBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primaryColor),
          fontFamily: 'Montserrat',
          useMaterial3: true,
        ),
        home: OnboardingScreen(),
      ),
    );
  }
}
