import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonAboutWidget extends StatelessWidget {
  const PokemonAboutWidget({super.key});

  String convertValue(value) {
    double convertedValue = value / 10;
    return convertedValue.toString();
  }

  Widget rowBuilder(String text, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        const  SizedBox(width: 25),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowBuilder('Habitat', "pokeData.species"),
          rowBuilder('Height', ' m'),
          rowBuilder('Weight', ' kg'),
          rowBuilder('Abilities', ''
              // toBeginningOfSentenceCase(pokeData.ability1) +
              //     '\n' +
              //     toBeginningOfSentenceCase(pokeData.ability2) +
              //     '\n' +
              //     toBeginningOfSentenceCase(pokeData.ability3),

              ),
        ],
      ),
    );
  }
}
