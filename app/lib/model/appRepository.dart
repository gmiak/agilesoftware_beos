import 'package:cloud_firestore/cloud_firestore.dart';

import 'movieModel.dart';

class AppRepository {
  static final AppRepository _appRepository = AppRepository._internal();

  final CollectionReference moviesCollection =
      FirebaseFirestore.instance.collection('movies');
  final CollectionReference likedMoviesCollection =
      FirebaseFirestore.instance.collection('likedMovies');

  factory AppRepository() {
    return _appRepository;
  }

  AppRepository._internal();

  Stream<QuerySnapshot> getStream() {
    return moviesCollection.snapshots();
  }

  addMovie(Movie movie) async {
    return await moviesCollection.add(movie.toJson());
  }

  clearMovies() async {
    return await moviesCollection.get().then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs) {ds.reference.delete()}
        });
  }

  updateMovieLiked(Movie movie, bool liked) async {
    var query = likedMoviesCollection.where("tmdbId", isEqualTo: movie.tmdbId);

    if (query != null) {
      var querySnapshot = query.get();

      if (querySnapshot != null) {
        await querySnapshot.then((docData) async => {
              if (docData.size == 0 && liked)
                {
                  movie.setLiked(liked),
                  await likedMoviesCollection.add(movie.toJson())
                }
              else if (docData.size != 0 && !liked)
                {
                  for (QueryDocumentSnapshot doc in docData.docs)
                    {doc.reference.delete()}
                }
            });
      }
    }
  }
}
