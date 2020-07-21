import 'package:cohoresourceapp_android/data/model/resource_model.dart';
import 'package:cohoresourceapp_android/data/repo/full_database_repo.dart';
import 'package:flutter/material.dart';

class Resource extends StatelessWidget {

    ResourceModel resource;
//    FullDatabaseRepo repo;

    List<ListTile> tiles = [];

    Resource({this.resource}) {
        tiles.add(ListTile(title: Text("Contact"), subtitle: Text("000-000-0000"),leading: Icon(Icons.phone, color: Colors.blueAccent,),));
        tiles.add(ListTile(title: Text("Locations"), subtitle: Text("14 White Oak Dr. \nConway, AR 72034"),));
        tiles.add(ListTile(title: Text("Description"), subtitle: Text(resource.description),));
        tiles.add(ListTile(title: Text("Services"), subtitle: Text(resource.services),));
        tiles.add(ListTile(title: Text("Required Documentation"), subtitle: Text(resource.description),));
        tiles.add(ListTile(title: Text("Hours"), subtitle: Text(resource.hours),));
    }

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return Scaffold(
            appBar: AppBar(title: Text(resource.name),),
            body: listView(),
        );
    }

    ListView listView() {
        return ListView.separated(
            itemBuilder: (context, index) {
                return tiles[index];
            },
            separatorBuilder: (context, index) {
                return Divider();
            },
            itemCount: tiles.length,
        );
    }
}