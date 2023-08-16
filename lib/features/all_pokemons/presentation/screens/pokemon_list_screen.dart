import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/core/constants/app_constants.dart';
import 'package:pokemon/core/constants/route_constants.dart';
import 'package:pokemon/core/utils/app_utils.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_event.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_state.dart';
import 'package:pokemon/features/all_pokemons/presentation/widgets/pokemon_list_item_widget.dart';
import 'package:pokemon/features/pokemon_details/presentation/blocs/pokemon_detail_cubit/pokemon_detail_cubit.dart';
import 'package:pokemon/features/pokemon_details/presentation/blocs/pokemon_species_cubit/pokemon_species_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:string_utils_extension/string_utils_extension.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final _scrollController = ScrollController();
  List<PokemonNameDataModel> pokemonList = [];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) return;
    if (_isBottom) {
      PokemonListBloc pokemonListBloc = context.read<PokemonListBloc>();
      if (pokemonListBloc.state is PokemonListLoading ||
          pokemonListBloc.state is PokemonListLoadingMore) return;
      if (pokemonListBloc.state is PokemonListSuccess) {
        PokemonListReqModel pokemonListReqModel = PokemonListReqModel(
            limit: pokemonPageLimit,
            offset:
                pokemonListBloc.pokemonListReqModel.offset + pokemonPageLimit);
        pokemonListBloc.pokemonListReqModel = pokemonListReqModel;
        pokemonListBloc.add(GetMorePokemonListEvent());
      }
    }
  }

  bool get _isBottom {
    return _scrollController.position.extentBefore >=
        _scrollController.position.maxScrollExtent * 0.88;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonListBloc, PokemonListState>(
      builder: (context, state) {
        if (state is PokemonListError) {
          showErrorDialog(
              errorMsg: state.errMsg,
              onRefresh: () {
                pokemonList.clear();
                PokemonListBloc pokemonListBloc =
                    context.read<PokemonListBloc>();
                pokemonListBloc.pokemonListReqModel =
                    PokemonListReqModel(limit: pokemonPageLimit, offset: 0);
                pokemonListBloc.add(GetPokemonListReTryEvent());
              });
        }
        if (state is PokemonListLoading ||
            state is PokemonListSuccess ||
            state is PokemonListLoadingMore) {
          pokemonList.addAll(state.pokemonListDataModel.pokemonNameList);
          return Scaffold(
              appBar: AppBar(title: const Text('Pokemon')),
              body: RefreshIndicator(
                onRefresh: () async {
                  pokemonList.clear();
                  PokemonListBloc pokemonListBloc =
                      context.read<PokemonListBloc>();
                  pokemonListBloc.pokemonListReqModel =
                      PokemonListReqModel(limit: pokemonPageLimit, offset: 0);
                  pokemonListBloc.add(GetPokemonListReTryEvent());
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Skeletonizer(
                          enabled: state is PokemonListLoading,
                          child: Column(
                            children: List.generate(
                                pokemonList.isNotEmpty
                                    ? pokemonList.length
                                    : 10,
                                (index) => Builder(builder: (itemContext) {
                                      return GestureDetector(
                                        onTap: () {
                                          int pokemonId = int.parse(
                                              pokemonList[index]
                                                      .url
                                                      .toString()
                                                      .isNotEmpty
                                                  ? parsePokemonIdFromUrl(
                                                      pokemonList[index]
                                                          .url
                                                          .toString())
                                                  : '0');
                                          itemContext
                                              .read<PokemonDetailCubit>()
                                              .emitGetPokemonDetails(pokemonId);
                                          itemContext
                                              .read<PokemonSpeciesCubit>()
                                              .emitGetPokemonSpecies(pokemonId);
                                          Navigator.pushNamed(itemContext,
                                              Routes.pokemonDetailScreen,
                                              arguments: {
                                                'name': pokemonList[index]
                                                    .name
                                                    .toString()
                                                    .toCapitalize(),
                                                "pokemonId": pokemonId
                                              });
                                        },
                                        child: PokemonListItemWidget(
                                          pokemonNameDataModel:
                                              pokemonList.isNotEmpty
                                                  ? pokemonList[index]
                                                  : const PokemonNameDataModel(
                                                      name: '', url: ''),
                                        ),
                                      );
                                    })),
                          )),
                      if (state is PokemonListLoadingMore)
                        const Skeletonizer(
                          enabled: true,
                          child: PokemonListItemWidget(
                              pokemonNameDataModel:
                                  PokemonNameDataModel(name: '', url: '')),
                        )
                    ],
                  ),
                ),
              ));
        }

        return const Scaffold(
            body:
                Padding(padding: EdgeInsets.all(20), child: SizedBox()));
      },
    );
  }
}
