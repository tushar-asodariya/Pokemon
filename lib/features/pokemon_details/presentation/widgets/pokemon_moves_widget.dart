import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pokemon/core/utils/map_card_color.dart';

class PokemonMovesWidget extends StatelessWidget {
  const PokemonMovesWidget({super.key});

  Widget moveLabel(
    String text,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: setTypeColor('fire'),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          toBeginningOfSentenceCase(text).toString(),
          style: GoogleFonts.poppins
            (
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
    final List moveList = [
      'fire',
      'fire',
      'fire',
      'fire',
      'fire',
      'fire',
      'fire',
      'fire',
      'fire'
    ];
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: GridView.count(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        childAspectRatio: 6 / 1.5,
        crossAxisSpacing: 4,
        children: moveList
            .map((item) => moveLabel(
                  item,
                ))
            .toList(),
      ),
    );
  }
}
