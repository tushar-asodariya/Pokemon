// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pokemon/core/utils/map_card_color.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_stats_data_model.dart';

class PokemonStatsWidget extends StatelessWidget {
  const PokemonStatsWidget({
    Key? key,
    required this.type,
    required this.pokemonStatsDataModel,
  }) : super(key: key);
  final String type;
  final PokemonStatsDataModel? pokemonStatsDataModel;
  String convertValue(value) {
    double initValue = value * 100;
    return initValue.toStringAsFixed(0);
  }

  Widget statsBar(String label, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w900,
              color: setTypeColor(type),
            ),
          ),
          const Spacer(),
          Text(
            convertValue(value),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w900,
              color: setTypeColor(type),
            ),
          ),
          Container(
            width: 250,
            height: 10,
            margin: const EdgeInsets.only(left: 15),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(setCardColor(type)),
                value: value,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          statsBar(
              'HP',
              (pokemonStatsDataModel?.hp ?? 0.0) > 100
                  ? 100
                  : pokemonStatsDataModel?.hp ?? 0.0),
          statsBar(
              'ATK',
              (pokemonStatsDataModel?.attack ?? 0.0) > 100
                  ? 100
                  : pokemonStatsDataModel?.attack ?? 0.0),
          statsBar(
              'DEF',
              (pokemonStatsDataModel?.defence ?? 0.0) > 100
                  ? 100
                  : pokemonStatsDataModel?.defence ?? 0.0),
          statsBar(
              'SATK',
              (pokemonStatsDataModel?.specialAttack ?? 0.0) > 100
                  ? 100.0
                  : pokemonStatsDataModel?.specialAttack ?? 0.0),
          statsBar(
              'SDEF',
              (pokemonStatsDataModel?.specialDefence ?? 0.0) > 100
                  ? 100
                  : pokemonStatsDataModel?.specialAttack ?? 0.0),
          statsBar(
              'SPD',
              (pokemonStatsDataModel?.speed ?? 0.0) > 100
                  ? 100
                  : pokemonStatsDataModel?.speed ?? 0.0),
        ],
      ),
    );
  }
}
