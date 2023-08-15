import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/utils/map_card_color.dart';

class PokemonStatsWidget extends StatelessWidget {
  const PokemonStatsWidget({super.key});

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
              color: setTypeColor('fire'),
            ),
          ),
          const Spacer(),
          Text(
            convertValue(value),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w900,
              color: setTypeColor('fire'),
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
                valueColor: AlwaysStoppedAnimation<Color>(setCardColor('fire')),
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
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Column(
        children: [
          statsBar('HP', 1),
          statsBar('ATK', 0.1),
          statsBar('DEF', 0.1),
          statsBar('SATK', 0.1),
          statsBar('SDEF', 0.1),
          statsBar('SPD', 0.1),
        ],
      ),
    );
  }
}
