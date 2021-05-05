import 'package:cloud_firestore/cloud_firestore.dart';

/*
Metod som lägger till nya medlemmar i members-fältet i Firestore givet att man har skickat med en epost från t.ex. en dialogruta och ID för listan.
*/

Future<void> addMemberToList(String email, String listID) async {
  List<String> memberToAddList = <String>[];
  memberToAddList.add(email);

  CollectionReference collectionReference = FirebaseFirestore.instance.collection('commonLists');
  collectionReference
  .doc(listID)
  .update({'members': FieldValue.arrayUnion(memberToAddList)});
}
