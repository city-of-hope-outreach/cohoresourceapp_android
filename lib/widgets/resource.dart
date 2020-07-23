import 'package:cohoresourceapp_android/data/model/contact_model.dart';
import 'package:cohoresourceapp_android/data/model/resource_model.dart';
import 'package:cohoresourceapp_android/data/repo/full_database_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Resource extends StatelessWidget {

    ResourceModel resource;
//    FullDatabaseRepo repo;

    List<Widget> tiles = [];

    Resource({this.resource}) {
        buildTiles();
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
        return ListView(
            children: tiles,
        );
    }

    void buildTiles() {
        tiles.add(ListTile(
            title: Text("Contact"),
        ));
        resource.contacts.forEach((contact) {
            Icon icon;

            switch (contact.type) {

              case ContactType.phone:
                icon = Icon(Icons.phone);
                break;
              case ContactType.email:
                icon = Icon(Icons.alternate_email);
                break;
              case ContactType.website:
                icon = Icon(Icons.link);
                break;
              case ContactType.fax:
                icon = Icon(Icons.mail_outline);
                break;
              case ContactType.errorType:
                icon = Icon(Icons.phonelink);
                break;
            }

            if (contact.name.length > 0) {
                tiles.add(ListTile(title: Text(contact.value), subtitle: Text(contact.name), leading: icon,));
            } else {
                tiles.add(ListTile(title: Text(contact.value), leading: icon,));
            }
        });

        tiles.add(Divider());

        tiles.add(ListTile(title: Text("Locations"),));

        resource.locations.asMap().forEach((index, location) {
            String sub = location.street1 + "\n";
            if (location.street2.length > 0) {
                sub = '$sub${location.street2}\n';
            }

            sub = '$sub${location.city}, ${location.state} ${location.zip}';

            String title = location.description;

            if (title.length == 0) {
                title = "Location #${index+1}";
            }

            tiles.add(ListTile(
                title: Text(title),
                subtitle: Text(sub),
                dense: true,
                leading: Icon(Icons.location_on),
            ));
        });

        tiles.add(Divider());

        tiles.add(ListTile(title: Text("Description"),));
        tiles.add(Padding(
            padding: EdgeInsets.fromLTRB(17, 0, 17, 16),
            child: MarkdownBody(data: resource.description,),
        ));

        tiles.add(Divider());

        tiles.add(ListTile(title: Text("Services")));
        tiles.add(Padding(
            padding: EdgeInsets.fromLTRB(17, 0, 17, 16),
            child: MarkdownBody(data: resource.services,),
        ));

        tiles.add(Divider());

        tiles.add(ListTile(title: Text("Required Documentation")));
        tiles.add(Padding(
            padding: EdgeInsets.fromLTRB(17, 0, 17, 16),
            child: MarkdownBody(data: resource.documentation,),
        ));

        tiles.add(Divider());

        tiles.add(ListTile(title: Text("Hours")));
        tiles.add(Padding(
            padding: EdgeInsets.fromLTRB(17, 0, 17, 16),
            child: MarkdownBody(data: resource.hours,),
        ));
    }
}