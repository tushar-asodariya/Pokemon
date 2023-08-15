import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/constants/app_constants.dart';
import 'package:pokemon/core/constants/route_constants.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_event.dart';
import 'package:pokemon/features/all_pokemons/presentation/blocs/pokemon_list_bloc/pokemon_list_state.dart';
import 'package:pokemon/features/all_pokemons/presentation/widgets/pokemon_list_item_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
        log('pokemon offset :: ${pokemonListReqModel.offset}');
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
                                (index) => GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            Routes.pokemonDetailScreen);
                                      },
                                      child: PokemonListItemWidget(
                                        pokemonNameDataModel:
                                            pokemonList.isNotEmpty
                                                ? pokemonList[index]
                                                : const PokemonNameDataModel(
                                                    name: '', url: ''),
                                      ),
                                    )),
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

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    state is PokemonListError
                        ? state.errMsg
                        : 'Something horrible happened',
                    style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      context
                          .read<PokemonListBloc>()
                          .add(GetPokemonListReTryEvent());
                    },
                    child: const Center(child: Icon(Icons.refresh)))
              ],
            ),
          ),
        );
      },
    );
  }
}
