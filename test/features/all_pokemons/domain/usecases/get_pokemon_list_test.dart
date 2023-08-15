
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon/features/all_pokemons/data/models/pokemon_list_req_model.dart';
import 'package:pokemon/features/all_pokemons/domain/entities/pokemon_name_data_model.dart';
import 'package:pokemon/features/all_pokemons/domain/repositories/pokemon_list_repository.dart';
import 'package:pokemon/features/all_pokemons/domain/usecases/get_pokemon_list.dart';
import 'get_pokemon_list_test.mocks.dart';
import 'package:mockito/annotations.dart';

// class MockPokemonListRepository extends Mock implements PokemonListRepository {}

@GenerateMocks([PokemonListRepository])
void main(){
  late GetPokemonList useCase;
  late MockPokemonListRepository mockPokemonListRepository;

  setUp(() {
    mockPokemonListRepository = MockPokemonListRepository();
    useCase = GetPokemonList(pokemonListRepository: mockPokemonListRepository);
  });
  
  final PokemonNameDataModel pokemonNameDataModel = PokemonNameDataModel(name: 'charmander', url: 'https://pokeapi.co/api/v2/pokemon/4/');
  final PokemonNameDataModel pokemonNameDataModel2 = PokemonNameDataModel(name: 'charmeleon', url: 'https://pokeapi.co/api/v2/pokemon/5/');
  final PokemonNameDataModel pokemonNameDataModel3 = PokemonNameDataModel(name: 'charizard', url: 'https://pokeapi.co/api/v2/pokemon/6/');
  final PokemonListDataModel pokemonListDataModel = PokemonListDataModel(next: 'https://pokeapi.co/api/v2/pokemon?offset=13&limit=10',
      previous: 'https://pokeapi.co/api/v2/pokemon?offset=0&limit=3',
      pokemonNameList: [pokemonNameDataModel, pokemonNameDataModel2,pokemonNameDataModel3]);
  final PokemonListReqModel pokemonListReqParamsModel = PokemonListReqModel(limit: 10,offset: 3);
  test('should get List of pokemon from repository', ()async{

    when(mockPokemonListRepository.getPokemonList(pokemonListReqParamsModel))
        .thenAnswer((_) async => Right(pokemonListDataModel));

    final result = await useCase(pokemonListReqParamsModel);

    expect(result,Right(pokemonListDataModel));

    verify(mockPokemonListRepository.getPokemonList(pokemonListReqParamsModel));

    verifyNoMoreInteractions(mockPokemonListRepository);

  });
  
}