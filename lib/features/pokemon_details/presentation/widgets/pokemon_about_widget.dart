import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/utils/app_utils.dart';
import 'package:pokemon/features/pokemon_details/domain/entities/pokemon_about_data_model.dart';
import 'package:pokemon/features/pokemon_details/presentation/blocs/pokemon_species_cubit/pokemon_species_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:string_utils_extension/string_utils_extension.dart';

class PokemonAboutWidget extends StatelessWidget {
  const PokemonAboutWidget({super.key, required this.pokemonAboutDataModel});

  final PokemonAboutDataModel? pokemonAboutDataModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<PokemonSpeciesCubit, PokemonSpeciesCubitState>(
            builder: (context, state) {
              if (state is PokemonSpeciesCubitError) {
                showErrorDialog(
                    errorMsg: state.errMsg,
                    onRefresh: () {
                      context.read<PokemonSpeciesCubit>().emitGetPokemonSpecies(
                          int.parse(
                              pokemonAboutDataModel!.pokemonId.toString()));
                    });
              }
              if (state is PokemonSpeciesCubitInternetError) {
                return const SizedBox();
              }

              return Skeletonizer(
                  enabled: state is PokemonSpeciesCubitLoading,
                  child: rowBuilder(
                      'Habitat',
                      state.pokemonSpeciesDataModel.pokemonHabitat
                          .toString()
                          .toCapitalize()));
            },
          ),
          rowBuilder('Height', '${pokemonAboutDataModel!.height} m'),
          rowBuilder('Weight', '${pokemonAboutDataModel!.weight} kg'),
          rowBuilder('Abilities', pokemonAboutDataModel!.ability),
        ],
      ),
    );
  }
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
        const SizedBox(width: 25),
        Text(value),
      ],
    ),
  );
}
