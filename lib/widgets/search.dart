import 'package:cohoresourceapp_android/data/model/resource_model.dart';
import 'package:cohoresourceapp_android/data/repo/full_database_repo.dart';
import 'package:cohoresourceapp_android/widgets/resource.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  FullDatabaseRepo repo;


  Search({this.repo});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<ResourceModel>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          searchBarStyle: SearchBarStyle(
              padding: EdgeInsets.symmetric(horizontal: 10)
          ),
          onSearch: search,
          placeHolder: Center(child: Text("Search for Resources")),
          emptyWidget: Center(child: Text("No Results Found")),
          mainAxisSpacing: 10,
          onItemFound: (ResourceModel resource, int index) {
            return ListTile(
              title: Text(resource.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
              leading: Icon(
                Icons.description,
                color: Colors.deepOrangeAccent,
              ),
              onTap: () => _pushRoute(context, resource),
            );
          },
        ),
      ),
    );
  }

  Future<List<ResourceModel>> search(String search) async {
    return widget.repo.searchResources(search);
  }

  void _pushRoute(BuildContext context, ResourceModel resource) {
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => Resource(resource: resource,),
      ),
    );
  }

}