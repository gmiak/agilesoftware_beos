import 'package:app/model/listModel.dart';
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

    await commonLists
        .doc(listId)
        .collection('likedMovies')
        .get()
        .then((snapshot) => {
              for (DocumentSnapshot ds in snapshot.docs)
                {likedMovies.add(Movie.fromFBJson(ds.data()))}
            });

    return likedMovies;
  }

  Future<void> deleteLikedMovie(
    String listId,
    Movie movie,
  ) async {
    await commonLists
        .doc(listId)
        .collection('likedList')
        .doc(movie.tmdbId.toString())
        .delete();
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
    return await commonLists
        .doc(listId)
        .collection('likedMovies')
        .get()
        .then((snapshot) => {
              for (DocumentSnapshot ds in snapshot.docs) {ds.reference.delete()}
            });
  }

  updateMovieLiked(String listId, Movie movie, bool liked) async {
    var query = commonLists
        .doc(listId)
        .collection('likedMovies')
        .where("tmdbId", isEqualTo: movie.tmdbId);

    if (query != null) {
      var querySnapshot = query.get();

      if (querySnapshot != null) {
        await querySnapshot.then((docData) async => {
              if (docData.size == 0 && liked)
                {
                  await commonLists
                      .doc(listId)
                      .collection('likedMovies')
                      .add(movie.toJson())
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

  Future<void> addMemberToList(String email, String listId) async {
    List<String> memberToAddToList = <String>[];
    memberToAddToList.add(email);

    await commonLists
        .doc(listId)
        .update({'members': FieldValue.arrayUnion(memberToAddToList)});
  }


  Future<void> addOwnerToList(String email, String listId) async {
    await commonLists
        .doc(listId)
        .update({'owner': email});
  }


  Future<void> createList(String listName, String creator) async {
    List<String> creatorToAdd = <String>[];
    creatorToAdd.add(creator);
    DocumentReference addedDocRef = commonLists.doc();
    String listId = addedDocRef.id;
    addedDocRef.set(
        {'members': FieldValue.arrayUnion(creatorToAdd), 'listName': listName, 'listId': listId});
    addMemberToList(creator, listId);
    addOwnerToList(creator, listId);
  }

  Future<List<CommonList>> getLists(String userEmail) async {
    List<CommonList> lists = <CommonList>[];
    Query memberQuery = commonLists.where('members', arrayContains: userEmail);
    await memberQuery.get().then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs)
            {lists.add(CommonList.fromFBJson(ds.data()))}
        });

    return lists;
  }
}
