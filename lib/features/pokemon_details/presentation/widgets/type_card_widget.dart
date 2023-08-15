import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pokemon/core/utils/map_card_color.dart';

class TypeCard extends StatelessWidget {
  final String type;
  const TypeCard(this.type, {super.key});
  @override
  Widget build(BuildContext context) {
    String typeText = toBeginningOfSentenceCase(type).toString();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      margin: const  EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: setTypeColor(type),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(typeText,
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
    );
  }
}
