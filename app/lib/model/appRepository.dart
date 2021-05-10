import 'package:cloud_firestore/cloud_firestore.dart';

import 'movieModel.dart';

class AppRepository {
  static final AppRepository _appRepository = AppRepository._internal();

  final CollectionReference moviesCollection =
      FirebaseFirestore.instance.collection('movies');
  final CollectionReference commonLists =
      FirebaseFirestore.instance.collection('commonLists');

  factory AppRepository() {
    return _appRepository;
  }

  AppRepository._internal();

  Stream<QuerySnapshot> getStream() {
    return moviesCollection.snapshots();
  }

  Future<List<Movie>> getMovies() async {
    List<Movie> movies = <Movie>[];

    await moviesCollection.get().then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs)
            {movies.add(Movie.fromFBJson(ds.data()))}
        });

    return movies;
  }

  Future<List<Movie>> getLikedMovies(String listId) async {
    List<Movie> likedMovies = <Movie>[];

    await commonLists.doc(listId).collection('likedMovies').get().then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs)
            {likedMovies.add(Movie.fromFBJson(ds.data()))}
        });

    return likedMovies;
  }

  Future<DocumentReference> addMovie(Movie movie) async {
    return await moviesCollection.add(movie.toJson());
  }

  Future<void> clearMovies() async {
    return await moviesCollection.get().then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs) {ds.reference.delete()}
        });
  }

  Future<void> clearLikedMovies(String listId) async {
    return await commonLists.doc(listId).collection('likedMovies').get().then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs) {ds.reference.delete()}
        });
  }
 

  updateMovieLiked(String listId, Movie movie, bool liked) async {
    var query = commonLists.doc(listId).collection('likedMovies').where("tmdbId", isEqualTo: movie.tmdbId);

    if (query != null) {
      var querySnapshot = query.get();

      if (querySnapshot != null) {
        await querySnapshot.then((docData) async => {
              if (docData.size == 0 && liked)
                {await commonLists.doc(listId).collection('likedMovies').add(movie.toJson())}
              else if (docData.size != 0 && !liked)
                {
                  for (QueryDocumentSnapshot doc in docData.docs)
                    {doc.reference.delete()}
                }
            });
      }
    }
  }

  Future<void> addMemberToList(String email, String listId) async {
    List<String> memberToAddToList = <String>[];
    memberToAddToList.add(email);

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('commonLists');

    await collectionReference
    .doc(listId)
    .update({'members': FieldValue.arrayUnion(memberToAddToList)});
}

}
