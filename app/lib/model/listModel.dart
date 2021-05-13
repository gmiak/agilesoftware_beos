/*
* Klassen bygger abstraktionen (en objektmodell) av en lista.
* */

class CommonList {
  final String listId;
  final String listName;
  final String listOwner;
  final List<String> members;
  final List<String> likedMovies;

  //constructor
  CommonList({this.listId, this.listName, this.listOwner, this.members, this.likedMovies});

  factory CommonList.fromFBJson(Map<String, dynamic> json) {
    return CommonList(
        listId: json["listId"],
        listName: json["listName"],
        listOwner: json["owner"],
        members:
            (json['members'] as List)?.map((member) => member as String)?.toList(),
        likedMovies:
            (json['likedMovies'] as List)?.map((likedMovies) => likedMovies as String)?.toList(),);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'listId': this.listId,
        'listName': this.listName,
        'owner': this.listOwner,
        'members': this.members,
        'likedMovies': this.likedMovies,
      };

  String getListName() {
    return listName;
  }

  List<String> getMembers() {
    return members;
  }

  String getListId() {
    return listId;
  }

  String getListOwner() {
    return listOwner;
  }
}
