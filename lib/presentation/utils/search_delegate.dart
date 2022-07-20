import 'package:flutter/material.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/presentation/screens/usersview_screen.dart';

class CustomSearchDelegate extends SearchDelegate {
// Demo list to show querying
  final List<SuperPassModel> passList;
  CustomSearchDelegate({required this.passList});

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    final searchTerms = passList.map((e) => e.title).toList();
    List<String> matchQuery = [];
    for (var pass in searchTerms) {
      if (pass.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(pass);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () => _openUsersView(context, result),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    final searchTerms = passList.map((e) => e.title).toList();
    for (var pass in searchTerms) {
      if (pass.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(pass);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            _openUsersView(context, result);
          },
        );
      },
    );
  }

  void _openUsersView(BuildContext context, String title) {
    close(context, null);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UsersViewScreen(
              superPassModel:
                  passList.firstWhere((element) => element.title == title)),
        ));
  }
}
