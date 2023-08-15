import 'package:flutter/material.dart';
import 'package:pokemon/features/all_pokemons/presentation/widgets/pokemon_list_item_widget.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Pokemon')),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (listContext, index) => PokemonListItemWidget()));
  }
}
