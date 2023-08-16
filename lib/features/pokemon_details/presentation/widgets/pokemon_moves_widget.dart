// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:pokemon/core/utils/map_card_color.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_moves_data_model.dart';

class PokemonMovesWidget extends StatelessWidget {
  final String type;
  final List<PokemonMovesDataModel>? pokemonMovesDataModelList;
  const PokemonMovesWidget({
    Key? key,
    required this.type,
    required this.pokemonMovesDataModelList,
  }) : super(key: key);

  Widget moveLabel(
    String text,
  ) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: setTypeColor(type),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          toBeginningOfSentenceCase(text).toString(),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            shadows: <Shadow>[
              const Shadow(
                offset: Offset(2, 2),
                blurRadius: 7,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        childAspectRatio: 6 / 3.5,
        crossAxisSpacing: 4,
        children: pokemonMovesDataModelList!
            .map((item) => moveLabel(
                  item.moves,
                ))
            .toList(),
      ),
    );
  }
}
