import 'package:flutter/material.dart';
import 'package:secure_call/utils/custom_colors.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No favorite contacts found"),
    );
  }
}
