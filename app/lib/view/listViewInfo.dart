import 'package:app/model/listModel.dart';
import 'package:flutter/material.dart';

import '../coList.dart';

///Klassen bygger list-element som visas på en användares huvudskärm.
class ListViewInfo extends StatelessWidget {
  ///Lista av listor för en användare.
  final List<CommonList> commonLists;

  ///Konstruktor
  ListViewInfo({this.commonLists});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: commonLists.length,
      itemBuilder: (context, index) {
        final list = commonLists[index];
        return ListTile(
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
        );
      },
    );
  }
}
