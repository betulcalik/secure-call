import 'package:flutter/material.dart';
import 'package:secure_call/features/call/bloc/call_bloc.dart';
import 'package:secure_call/features/call/utils/call_repository.dart';
import 'package:secure_call/features/calls/bloc/calls_bloc.dart';
import 'package:secure_call/features/calls/bloc/calls_event.dart';
import 'package:secure_call/features/calls/utils/calls_repository.dart';
import 'package:secure_call/features/contacts/bloc/contacts_bloc.dart';
import 'package:secure_call/features/contacts/bloc/contacts_event.dart';
import 'package:secure_call/features/contacts/utils/contact_repository.dart';
import 'package:provider/provider.dart';
import 'package:secure_call/features/favorites/bloc/favorites_event.dart';
import 'package:secure_call/features/main/main_screen.dart';
import 'package:secure_call/features/registration/utils/registration_repository.dart';
import 'package:secure_call/features/registration/widgets/onboarding_screen.dart';
import 'package:secure_call/utils/custom_colors.dart';
import 'features/favorites/bloc/favorites_bloc.dart';
import 'features/favorites/utils/favorites_repository.dart';
import 'features/registration/bloc/registration_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ContactsBloc contactsBloc = ContactsBloc(ContactRepository())..add(LoadContacts());
  final FavoritesBloc favoritesBloc = FavoritesBloc(FavoritesRepository(ContactRepository()))..add(LoadFavoriteContacts());
  final RegistrationBloc registrationBloc = RegistrationBloc(RegistrationRepository());
  final CallsBloc callsBloc = CallsBloc(CallsRepository(ContactRepository()))..add(LoadRecentCalls());
  final CallBloc callBloc = CallBloc(CallRepository());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ContactsBloc>(create: (context) => contactsBloc),
        Provider<FavoritesBloc>(create: (context) => favoritesBloc),
        Provider<RegistrationBloc>(create: (context) => registrationBloc),
        Provider<CallsBloc>(create: (context) => callsBloc),
        Provider<CallBloc>(create: (context) => callBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primaryColor),
          fontFamily: 'Montserrat',
          useMaterial3: true,
        ),
        home: MainScreen(),
      ),
    );
  }
}
