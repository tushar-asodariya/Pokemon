import 'package:flutter/material.dart';
import 'package:pokemon/core/constants/route_constants.dart';
import 'package:pokemon/features/all_pokemons/presentation/screens/pokemon_list_screen.dart';
import 'package:pokemon/features/pokemon_details/presentation/screens/pokemon_detail_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.pokemonListScreen:
        return MaterialPageRoute(
            builder: (_) => const PokemonListScreen(), settings: settings);
      case Routes.pokemonDetailScreen:
        return MaterialPageRoute(
            builder: (_) => const PokemonDetailScreen(), settings: settings);
      default:
        return null;
    }
  }
}
