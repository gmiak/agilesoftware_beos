import 'package:tmdb_api/tmdb_api.dart';

main() async {
//Nycklar för att göra anrop till databasen.
  var apiKey = 'b4cc0c5b697aa656e542ee4110939d7e';
  var apiReadAccessTokenV4 =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNGNjMGM1YjY5N2FhNjU2ZTU0MmVlNDExMDkzOWQ3ZSIsInN1YiI6IjYwNzg3NGRkMWIxZjNjMDA1N2I4OGYzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qN2UHE8GkoB0tCf0X2xGIkJFeXgMkhx8W2-lBv4Cotk';

//Nedan följer 3 olika sätt att anropa databasen. Gissar att vi kommer använda den översta utan logg mest.
//Då borde vi kunna läsa i api:t vad som finns och skriva: await tmdb.v3.<<kategori>>.<<funktion>>();
//https://developers.themoviedb.org/3/

  //api with out console logs
  TMDB tmdb = TMDB(ApiKeys(apiKey, apiReadAccessTokenV4));
  print(await tmdb.v3.movies.getPouplar());

  //api with showing all console logs
  TMDB tmdbWithLogs = TMDB(
    ApiKeys(apiKey, apiReadAccessTokenV4),
    logConfig: ConfigLogger.showAll(),
  );
  print(await tmdbWithLogs.v3.movies.getPouplar());

  //api with showing all console logs
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apiKey, apiReadAccessTokenV4),
    logConfig: ConfigLogger(
      //must be true than only all other logs will be shown
      showLogs: true,
      showErrorLogs: true,
    ),
  );
  //print(await tmdbWithCustomLogs.v3.movies.getPouplar());
}
