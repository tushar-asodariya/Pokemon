class ApiPath{
  static const String baseUrl = 'https://pokeapi.co/api/v2';
  static String pokemonGifBaseUrl =
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/';
  static String pokemonPngBaseUrl =
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/';

  //pokemons list
  static const String pokemonList = '$baseUrl/pokemon';

  //pokemons species
  static const String pokemonSpeciesDetails = '$baseUrl/pokemon-species';
}