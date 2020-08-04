import 'package:cohoresourceapp_android/data/model/contact_model.dart';
import 'package:cohoresourceapp_android/data/model/location_model.dart';
import 'package:cohoresourceapp_android/data/model/resource_model.dart';
import 'package:cohoresourceapp_android/data/repo/full_database_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

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
        buildContact();

        buildLocations();

        if (resource.description.length > 0) {
          tiles.add(ListTile(title: Text("Description"),));
          tiles.add(Padding(
              padding: EdgeInsets.fromLTRB(17, 0, 17, 16),
              child: MarkdownBody(data: resource.description,),
          ));

          tiles.add(Divider());
        }


        if (resource.services.length > 0) {
          tiles.add(ListTile(title: Text("Services")));
          tiles.add(Padding(
              padding: EdgeInsets.fromLTRB(17, 0, 17, 16),
              child: MarkdownBody(data: resource.services,),
          ));

          tiles.add(Divider());

        }


        if (resource.documentation.length > 0) {
          tiles.add(ListTile(title: Text("Required Documentation")));
          tiles.add(Padding(
              padding: EdgeInsets.fromLTRB(17, 0, 17, 16),
              child: MarkdownBody(data: resource.documentation,),
          ));

          tiles.add(Divider());
        }

        if (resource.hours.length > 0) {
          tiles.add(ListTile(title: Text("Hours")));
          tiles.add(Padding(
              padding: EdgeInsets.fromLTRB(17, 0, 17, 16),
              child: MarkdownBody(data: resource.hours,),
          ));
        }

        if (tiles.last is Divider) {
            tiles.removeLast();
        }
    }

    void buildContact() {
        if (resource.contacts.length > 0) {
          tiles.add(ListTile(
              title: Text("Contact"),
          ));
          resource.contacts.forEach((contact) {
              Icon icon;
              String type = "";

              switch (contact.type) {

                  case ContactType.phone:
                      icon = Icon(Icons.phone);
                      type = "Phone";
                      break;
                  case ContactType.email:
                      icon = Icon(Icons.alternate_email);
                      type = "Email";
                      break;
                  case ContactType.website:
                      icon = Icon(Icons.link);
                      type = "Website";
                      break;
                  case ContactType.fax:
                      icon = Icon(Icons.mail_outline);
                      type = "Fax";
                      break;
                  case ContactType.errorType:
                      icon = Icon(Icons.phonelink);
                      type = "Unknown contact type";
                      break;
              }

              String name = contact.name;

              if (name.length == 0) {
                  name = type;
              }

              tiles.add(
                  ListTile(
                      title: Text(contact.value),
                      subtitle: Text(name),
                      leading: icon,
                      onTap: () => openContact(contact),
                  )
              );
          });
        }

        tiles.add(Divider());
    }

    void buildLocations() {
        if (resource.locations.length > 0) {
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
        }
    }

    void openContact(ContactModel contact) {
        String scheme = "";
        switch (contact.type) {

          case ContactType.phone:
            scheme = "tel";
            break;
          case ContactType.email:
            scheme = "mailto";
            break;
          case ContactType.website:
            scheme = "http";
            break;
          case ContactType.fax:
            return;
            break;
          case ContactType.errorType:
            return;
            break;
        }

        Uri uri;

        if (scheme.length > 0) {
            uri = Uri(scheme: scheme, path: contact.value,);
        } else {
            uri = Uri(path: contact.value,);
        }

        launch(uri.toString());
    }

    void openLocation(LocationModel location) {

    }
}