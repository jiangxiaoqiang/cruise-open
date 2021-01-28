import 'dart:math';

import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {


    return ListView.builder(
      itemCount: Random().nextInt(10),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('result $index'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(title: Text('Suggest 01')),
        ListTile(title: Text('Suggest 02')),
        ListTile(title: Text('Suggest 03')),
        ListTile(title: Text('Suggest 04')),
        ListTile(title: Text('Suggest 05')),
      ],
    );
  }
}
