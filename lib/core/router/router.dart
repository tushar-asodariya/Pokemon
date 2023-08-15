import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokemon/core/constants/route_constants.dart';
import 'package:pokemon/features/all_pokemons/presentation/screens/pokemon_list_screen.dart';

class AppRouter{

   Route? onGenerateRoute(RouteSettings settings) {
    switch(settings.name){
      case Routes.pokemonListScreen:
        return MaterialPageRoute(builder: (_) => PokemonListScreen());
      default : 
        return null;
    }
   }
}