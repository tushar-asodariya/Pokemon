parsePokemonIdFromUrl(String pokemonUrl) {
  return pokemonUrl.split('/').toSet().toList().last;
}
