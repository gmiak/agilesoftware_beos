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
                      SizedBox(
                        height: 20,
                      ),
                      list.listName != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                  Icon(
                                    Icons.list,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(list.listName),
                                ])
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                  Icon(
                                    Icons.list,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('default value'),
                                ])
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
