import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/constants/color_constants.dart';

import 'package:pokemon/core/utils/map_card_color.dart';
import 'package:pokemon/features/pokemon_details/presentation/widgets/pokemon_about_widget.dart';
import 'package:pokemon/features/pokemon_details/presentation/widgets/pokemon_moves_widget.dart';
import 'package:pokemon/features/pokemon_details/presentation/widgets/pokemon_stats_widget.dart';
import 'package:pokemon/features/pokemon_details/presentation/widgets/type_card_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonDetailScreen extends StatefulWidget {
  const PokemonDetailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: false,
      child: Scaffold(
          backgroundColor: setCardColor('fire'),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: 35,
                  top: 20,
                  left: 35,
                  child: CachedNetworkImage(
                    height: 280,
                    width: 200,
                    fit: BoxFit.contain,
                    imageUrl:
                        // "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png",
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/6.gif",
                    placeholder: (context, url) => Shimmer(
                      child: Container(
                        decoration: BoxDecoration(
                          color: setCardColor('fire').withOpacity(0.8),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => CachedNetworkImage(
                      height: 280,
                      width: 200,
                      fit: BoxFit.contain,
                      imageUrl:
                          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png",
                      placeholder: (context, url) => Shimmer(
                        child: Container(
                          decoration: BoxDecoration(
                            color: setCardColor('fire').withOpacity(0.8),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(
                    left: 20,
                    top: MediaQuery.of(context).size.height * 0.34,
                    bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Char',
                      style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '#1',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorConstant.darkCharcoal),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.68,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.42),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 20, top: 20, bottom: 20, right: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [TypeCard('fire')]),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 20, right: 20),
                            child: Text(
                              '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.justify,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buttonBuilder('ABOUT', 0),
                              _buttonBuilder('STATS', 1),
                              _buttonBuilder('MOVES', 2),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 20, right: 20),
                            child: _selectedIndex == 0
                                ? const PokemonAboutWidget()
                                : _selectedIndex == 1
                                    ? const PokemonStatsWidget()
                                    : const PokemonMovesWidget()),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3)),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buttonBuilder(String title, int myIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = myIndex;
        });
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _selectedIndex == myIndex
              ? setTypeColor('fire')
              : Colors.transparent,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: _selectedIndex == myIndex
                      ? Colors.white
                      : setTypeColor('fire'),
                )),
          ),
        ),
      ),
    );
  }
}
