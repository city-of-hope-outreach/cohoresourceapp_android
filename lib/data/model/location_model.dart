import 'package:equatable/equatable.dart';

class LocationModel extends Equatable{
    final int id;
    final String description;
    final String street1;
    final String street2;
    final String city;
    final String state;
    final String zip;

  LocationModel({this.id, this.description, this.street1, this.street2, this.city, this.state, this.zip});

  @override
  List<Object> get props => [id];

  static LocationModel locationFromDynMap(Map<dynamic, dynamic> dynMap) {
      return LocationModel(
          id: dynMap['id'],
          description: dynMap['desc'],
          street1: dynMap['street1'],
          street2: dynMap['street2'],
          city: dynMap['city'],
          state: dynMap['state'],
          zip: dynMap['zip']
      );
  }
}