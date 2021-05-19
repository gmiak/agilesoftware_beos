import 'package:app/model/appRepository.dart';
import 'package:app/model/listModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:app/networking/authentication.dart';

import '../coList.dart';

///Klassen bygger list-element som visas på en användares huvudskärm.
class ListViewInfo extends StatefulWidget {
  ///Lista av listor för en användare.
  final List<CommonList> commonLists;

  ///Konstruktor
  ListViewInfo({this.commonLists});

  @override
  _ListViewInfoState createState() => _ListViewInfoState();
}

class _ListViewInfoState extends State<ListViewInfo> {
  ///För att komma åt email
  Authentication auth = Authentication();

  ///Används för att komma åt deleteList
  final AppRepository apprepository = AppRepository();

  ///Picks a string depending on if listOwner or not.
  String getmessage(int index) {
    String message;
    if (widget.commonLists[index].getListOwner() == auth.email) {
      message = "Delete";
    } else {
      message = "Leave";
    }
    return message;
  }

  ///Picks an Icon depending on if listOwner or not.
  IconData getIcon(int index) {
    if (widget.commonLists[index].getListOwner() == auth.email) {
      return Icons.delete;
    } else {
      return Icons.exit_to_app;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.commonLists.length,
      itemBuilder: (context, index) {
        var list = widget.commonLists[index];
        return Slidable(
          actionPane: SlidableStrechActionPane(),
          child: ListTile(
            title: Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(list.listName != null
                            ? list.listName
                            : 'default value')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => new CoList(commonList: list),
                ),
              );
            },
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: getmessage(index),
              color: Colors.red,
              icon: getIcon(index),
              onTap: () {
                setState(() {
                  apprepository.deleteList(list, auth.email);
                  widget.commonLists.removeAt(index);
                });
              },
            )
          ],
        );
      },
    );
  }
}
