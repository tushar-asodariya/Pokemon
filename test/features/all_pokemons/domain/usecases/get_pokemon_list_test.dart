
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon/features/all_pokemons/domain/repositories/pokemon_list_repository.dart';
import 'package:pokemon/features/all_pokemons/domain/usecases/get_pokemon_list.dart';
import '../../../../test_data/read_test_data_files.dart';
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
  
   test('should get List of pokemon from repository', ()async{

    when(mockPokemonListRepository.getPokemonList(tPokemonListReqModel))
        .thenAnswer((_) async => Right(tPokemonListRespModel));

    final result = await useCase(tPokemonListReqModel);

    expect(result,Right(tPokemonListRespModel));

    verify(mockPokemonListRepository.getPokemonList(tPokemonListReqModel));

    verifyNoMoreInteractions(mockPokemonListRepository);

  });
  
}