// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pokemon/core/constants/api_path_constants.dart';
import 'package:pokemon/core/utils/app_utils.dart';
import 'package:pokemon/core/utils/view_more.dart';
import 'package:pokemon/features/pokemon_details/presentation/blocs/pokemon_detail_cubit/pokemon_detail_cubit.dart';
import 'package:pokemon/features/pokemon_details/presentation/blocs/pokemon_species_cubit/pokemon_species_cubit.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:pokemon/core/constants/color_constants.dart';
import 'package:pokemon/core/utils/map_card_color.dart';
import 'package:pokemon/features/pokemon_details/presentation/widgets/pokemon_about_widget.dart';
import 'package:pokemon/features/pokemon_details/presentation/widgets/pokemon_moves_widget.dart';
import 'package:pokemon/features/pokemon_details/presentation/widgets/pokemon_stats_widget.dart';
import 'package:pokemon/features/pokemon_details/presentation/widgets/type_card_widget.dart';
import 'package:string_utils_extension/string_utils_extension.dart';

class PokemonDetailScreen extends StatefulWidget {
  const PokemonDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  int _selectedIndex = 0;
  late String name;
  late int pokemonId;
  String type = '';
  @override
  void initState() {
    super.initState();
    name = '';
    pokemonId = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dynamic args = ModalRoute.of(context)?.settings.arguments;
      name = args['name'] ?? '';
      pokemonId = args['pokemonId'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailCubit, PokemonDetailCubitState>(
      builder: (context, state) {
        if (state is PokemonDetailCubitError) {
          showErrorDialog(
              errorMsg: state.errMsg,
              onRefresh: () {
                context
                    .read<PokemonDetailCubit>()
                    .emitGetPokemonDetails(pokemonId);
                context
                    .read<PokemonSpeciesCubit>()
                    .emitGetPokemonSpecies(pokemonId);
              });
        }
        if (state is PokemonDetailCubitSuccess) {
          type =
              state.pokemonDetailsDataModel.typesDataModel?.first.type.trim() ??
                  '';
        }
        return Scaffold(
            backgroundColor: setCardColor(type),
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
                          "${ApiPath.pokemonGifBaseUrl}$pokemonId.gif",
                      placeholder: (context, url) => Shimmer(
                        child: Container(
                          decoration: BoxDecoration(
                            color: setCardColor(type).withOpacity(0.8),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => CachedNetworkImage(
                        height: 280,
                        width: 200,
                        fit: BoxFit.contain,
                        imageUrl:
                            "${ApiPath.pokemonPngBaseUrl}$pokemonId.png",
                        placeholder: (context, url) => Shimmer(
                          child: Container(
                            decoration: BoxDecoration(
                              color: setCardColor(type).withOpacity(0.8),
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
                        name,
                        style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '#$pokemonId',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.darkCharcoal),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.68,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.43),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeletonizer(
                            enabled: state is PokemonDetailCubitLoading,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(
                                      state.pokemonDetailsDataModel
                                              .typesDataModel?.length ??
                                          0,
                                      (index) => TypeCard(state
                                          .pokemonDetailsDataModel
                                          .typesDataModel![index]
                                          .type
                                          .toString()))),
                            ),
                          ),
                          BlocBuilder<PokemonSpeciesCubit,
                              PokemonSpeciesCubitState>(
                            builder: (context, speciesState) {
                              if (speciesState is PokemonSpeciesCubitError) {
                                showErrorDialog(
                                    errorMsg: speciesState.errMsg,
                                    onRefresh: () {
                                      context
                                          .read<PokemonSpeciesCubit>()
                                          .emitGetPokemonSpecies(
                                              int.parse(pokemonId.toString()));
                                    });
                              }
                              if (state is PokemonSpeciesCubitInternetError) {
                                return const SizedBox();
                              }
                              return Skeletonizer(
                                  enabled: speciesState
                                      is PokemonSpeciesCubitLoading,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 20,
                                        bottom: 20,
                                        right: 20),
                                    child: ViewMore(
                                      toBeginningOfSentenceCase(speciesState
                                              .pokemonSpeciesDataModel
                                              .description
                                              .toString()
                                              .toCapitalize())
                                          .toString(),
                                      trimLines: 7,
                                      // preDataText: "Lorem Ipsum".toUpperCase(),
                                      moreStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: setCardColor(type),
                                      ),
                                      lessStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: setCardColor(type),
                                      ),
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.justify,

                                      colorClickableText: Colors.pink,
                                      trimMode: Trimer.line,
                                      trimCollapsedText: '...read more',
                                      trimExpandedText: ' view less',
                                    ),
                                  ));
                            },
                          ),
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
                                  ? state.pokemonDetailsDataModel
                                              .aboutDataModel !=
                                          null
                                      ? Skeletonizer(
                                          enabled: state
                                              is PokemonDetailCubitLoading,
                                          child: PokemonAboutWidget(
                                            pokemonAboutDataModel: state
                                                .pokemonDetailsDataModel
                                                .aboutDataModel,
                                          ))
                                      : const SizedBox()
                                  : _selectedIndex == 1
                                      ? state.pokemonDetailsDataModel
                                                  .aboutDataModel !=
                                              null
                                          ? Skeletonizer(
                                              enabled: state
                                                  is PokemonDetailCubitLoading,
                                              child: PokemonStatsWidget(
                                                pokemonStatsDataModel: state
                                                    .pokemonDetailsDataModel
                                                    .statsDataModel,
                                                type: type,
                                              ))
                                          : const SizedBox()
                                      : state.pokemonDetailsDataModel
                                                  .aboutDataModel !=
                                              null
                                          ? Skeletonizer(
                                              enabled: state
                                                  is PokemonDetailCubitLoading,
                                              child: PokemonMovesWidget(
                                                pokemonMovesDataModelList: state
                                                    .pokemonDetailsDataModel
                                                    .movesDataModel,
                                                type: type,
                                              ))
                                          : const SizedBox()),
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
            ));
      },
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
              ? setTypeColor(type)
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
                      : setTypeColor(type),
                )),
          ),
        ),
      ),
    );
  }
}
