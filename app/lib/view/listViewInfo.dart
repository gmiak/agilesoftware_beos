import 'package:app/model/listModel.dart';
import 'package:flutter/material.dart';

/// Klassen tar in en parameter som är listan av alla filmer,
///Därmed målas varje filmer med samma format på skärmen.

//TODO Fixa allt.

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
          title: Row(
            children: [
              SizedBox(
                width: 100,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(list.listName)],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
