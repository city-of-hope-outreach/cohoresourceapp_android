import 'dart:math';

import 'package:equatable/equatable.dart';

import './county_model.dart';
import './category_model.dart';
import './contact_model.dart';
import './location_model.dart';

class ResourceModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String services;
  final String documentation;
  final String hours;
  final String tags;

  final List<int> categoryIDs;
  final List<int> countyIDs;
  final List<ContactModel> contacts;
  final List<LocationModel> locations;

  ResourceModel(
      {this.id,
      this.name,
      this.description,
      this.services,
      this.documentation,
      this.hours,
      this.tags,
      this.categoryIDs,
      this.countyIDs,
      this.contacts,
      this.locations});

  @override
  List<Object> get props => [id];

  static ResourceModel resourceFromDynMap(Map<dynamic, dynamic> dynMap) {
    List<int> categories = [];

    if (dynMap.containsKey('categories')) {
        categories = List<int>.from(dynMap['categories']);
    } else {
        print('No category key for ${dynMap['name']}');
    }

    List<int> counties = [];

    if (dynMap.containsKey('counties')) {
        counties = List<int>.from(dynMap['counties']);
    } else {
        print('No county key for ${dynMap['name']}');
    }


    List<ContactModel> contacts = [];
    List<LocationModel> locations = [];

    if (dynMap.containsKey('contact')) {
        dynMap['contact'].forEach((item) {
            ContactModel contactModel = ContactModel.contactFromDynMap(item);
            if (contactModel != null) {
                contacts.add(contactModel);
            } else {
                print('Got null value from $item');
            }
        });
    }

    if (dynMap.containsKey('locations')) {
        dynMap['locations'].forEach((item) {
            LocationModel location = LocationModel.locationFromDynMap(item);
            if (location != null) {
                locations.add(location);
            } else {
                print('Got null value from location $item');
            }
        });
    }

    return ResourceModel(
      id: dynMap['id'],
      name: dynMap['name'],
      description: dynMap['description'],
      services: dynMap['services'],
      documentation: dynMap['documentation'],
      hours: dynMap['hours'],
      tags: dynMap['tags'],
      categoryIDs: categories,
      countyIDs: counties,
      contacts: contacts,
      locations: locations,
    );
  }
}
