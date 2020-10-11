import 'package:equatable/equatable.dart';

class LocationModel extends Equatable{
    final String description;
    final String street1;
    final String street2;
    final String city;
    final String state;
    final String zip;

  LocationModel({this.description, this.street1, this.street2, this.city, this.state, this.zip});

  @override
  String toString() {
    String str = '';
    if (street1 != null && street1 != '') {
        str += '$street1 ';
    }

    if (street2 != null && street2 != '') {
        str += '$street2 ';
    }

    if (city != null && city != '') {
        str += '$city, ';
    }

    if (state != null && state != '') {
        str += '$state ';
    }

    if (zip != null && zip != '') {
        str += '$zip';
    }


    return str;
  }

  @override
  List<Object> get props => [description, street1, street2, city, state, zip];

    Map<dynamic, dynamic> toDynMap() {
        Map<dynamic, dynamic> loc = new Map();
        loc['desc'] = this.description;
        loc['street1'] = this.street1;
        loc['street2'] = this.street2;
        loc['city'] = this.city;
        loc['state'] = this.state;
        loc['zip'] = this.zip;

        return loc;
    }

  static LocationModel locationFromDynMap(Map<dynamic, dynamic> dynMap) {
      return LocationModel(
          description: dynMap['desc'],
          street1: dynMap['street1'],
          street2: dynMap['street2'],
          city: dynMap['city'],
          state: dynMap['state'],
          zip: dynMap['zip']
      );
  }
}