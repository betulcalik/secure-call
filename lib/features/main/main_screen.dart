import 'package:flutter/material.dart';
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
                }
            });
        },
        selectedIndex: currentPageIndex,
        height: 60,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.star),
            icon: Icon(Icons.star_border),
            label: "Favorites",
          ),
          NavigationDestination(
              selectedIcon: Icon(Icons.call),
              icon: Icon(Icons.call),
              label: "Calls",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: "Contacts",
          ),
        ],
      ),
      body: [
          FavoritesScreen(),
          Container(),
          ContactsScreen(),
      ][currentPageIndex],
    );
  }
}
