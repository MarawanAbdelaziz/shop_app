import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Favorites Screen',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
