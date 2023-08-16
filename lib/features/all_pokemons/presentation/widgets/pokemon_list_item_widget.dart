import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/constants/color_constants.dart';
import 'package:pokemon/core/utils/app_utils.dart';
import 'package:pokemon/core/utils/map_card_color.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';
import 'package:pokemon/features/pokemon_details/presentation/blocs/pokemon_species_cubit/pokemon_species_cubit.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:string_utils_extension/string_utils_extension.dart';

class PokemonListItemWidget extends StatelessWidget {
  final PokemonNameDataModel pokemonNameDataModel;
  const PokemonListItemWidget({required this.pokemonNameDataModel, super.key});

  @override
  Widget build(BuildContext context) {
    String id = pokemonNameDataModel.url.toString().isNotEmpty
        ? parsePokemonIdFromUrl(pokemonNameDataModel.url.toString())
        : '';
    return BlocBuilder<PokemonSpeciesCubit, PokemonSpeciesCubitState>(
      builder: (context, state) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
          child: Container(
            decoration: BoxDecoration(
                color: setCardColor(''),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#$id',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.darkCharcoal),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        pokemonNameDataModel.name.toString().toCapitalize(),
                        style: GoogleFonts.poppins(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                      color: setCardColor(''),
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: id.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl:
                              // "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png",
                              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/$id.gif",
                          placeholder: (context, url) => Shimmer(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              CachedNetworkImage(
                            imageUrl:
                                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png",
                            placeholder: (context, url) => Shimmer(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )
                      : const Icon(Icons.error),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
