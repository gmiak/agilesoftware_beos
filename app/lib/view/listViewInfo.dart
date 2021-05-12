import 'package:app/model/listModel.dart';
import 'package:flutter/material.dart';

import '../coList.dart';

class ListViewInfo extends StatelessWidget {
  final List<CommonList> commonLists;

  ///constructor
  ListViewInfo({this.commonLists});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: commonLists.length,
      itemBuilder: (context, index) {
        final list = commonLists[index];
        return ListTile(
          //TODO Fixa så det ser snyggt ut.
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
                builder: (_) => CoList(listId: list.listId),
              ),
            );
          },
        );
      },
    );
  }
}
