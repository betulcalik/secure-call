import 'package:flutter/material.dart';
import 'package:secure_call/features/calls/widgets/calls_screen.dart';
import 'package:secure_call/features/contacts/constants/contact_card_icon_type.dart';
import 'package:secure_call/features/favorites/widgets/add_favorite_screen.dart';
import 'package:secure_call/features/profile/widgets/profile_screen.dart';
import '../../utils/custom_colors.dart';
import 'package:secure_call/features/contacts/widgets/contacts_screen.dart';
import '../favorites/widgets/favorites_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;
  String appBarTitle = 'Favorites';

  void _showAddFavoriteScreen(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return const AddFavoriteScreen();
          }
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Source Sans 3',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: CustomColors.secondaryColor,
        actions: currentPageIndex == 0 ? [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  _showAddFavoriteScreen(context);
                },
                mini: true,
                backgroundColor: CustomColors.primaryColor,
                child: const Icon(Icons.add),
              ),
            )
        ] : [],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
            setState(() {
                currentPageIndex = index;
                switch(index) {
                  case 0: { appBarTitle = 'Favorites'; }
                  break;
                  case 1: { appBarTitle = 'Calls'; }
                  break;
                  case 2: { appBarTitle = 'Contacts'; }
                  break;
                  case 3: { appBarTitle = "Profile"; }
                  break;
                }
            });
        },
        selectedIndex: currentPageIndex,
        height: 60,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(
                Icons.favorite,
                color: Colors.red.shade300,
            ),
            icon: const Icon(Icons.favorite_border),
            label: "Favorites",
          ),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.call,
                color: Colors.cyan.shade300,
              ),
              icon: const Icon(Icons.call_outlined),
              label: "Calls",
          ),
          NavigationDestination(
            selectedIcon: Icon(
                Icons.person,
                color: Colors.orange.shade300,
            ),
            icon: const Icon(Icons.person_outline),
            label: "Contacts",
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: Colors.deepPurple.shade300,
            ),
            icon: const Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
      body: [
          const FavoritesScreen(),
          const CallsScreen(),
          const ContactsScreen(iconType: ContactCardIconType.call),
          const ProfileScreen()
      ][currentPageIndex],
    );
  }
}
