import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonListBloc, PokemonListState>(
      listener: (context, state) {
        // TODO: implement listener
        print(
            '@@@ state :: ${state.pokemonListDataModel.pokemonNameList.length}');
        print('@@@ state :: ${state is PokemonListLoading}');
        print('@@@ state :: ${state is PokemonListSuccess}');
      },
      builder: (context, state) {
        print(
            '@@@ state builder :: ${state.pokemonListDataModel.pokemonNameList.length}');
        print('@@@ state :: ${state is PokemonListLoading}');
        print('@@@ state :: ${state is PokemonListSuccess}');
        if (state is PokemonListLoading || state is PokemonListSuccess) {
          return Scaffold(
              appBar: AppBar(title: Text('Pokemon')),
              body: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<PokemonListBloc>()
                      .add(GetPokemonListReTryEvent());
                },
                child: Skeletonizer(
                  enabled: state is PokemonListLoading,
                  child: ListView.builder(
                      itemCount: state is PokemonListSuccess
                          ? state.pokemonListDataModel.pokemonNameList.length
                          : 10,
                      itemBuilder: (listContext, index) =>
                          PokemonListItemWidget(
                            pokemonNameDataModel: state.pokemonListDataModel
                                    .pokemonNameList.isNotEmpty
                                ? state
                                    .pokemonListDataModel.pokemonNameList[index]
                                : PokemonNameDataModel(name: '', url: ''),
                          )),
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
                    style: GoogleFonts.roboto(
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
                    child: Center(child: Icon(Icons.refresh)))
              ],
            ),
          ),
        );
      },
    );
  }
}
