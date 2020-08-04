import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
    final String name;
    final String value;
    final ContactType type;

  ContactModel({this.name, this.value, this.type});

  @override
  List<Object> get props => [name, value, type];

  static ContactModel contactFromDynMap(Map<dynamic, dynamic> dynMap) {
      return ContactModel(
          name: dynMap['name'],
          value: dynMap['value'],
          type: contactTypeFromInt(dynMap['typeInt'])
      );
  }

  static ContactType contactTypeFromInt(int typeInt) {
      List<ContactType> types = ContactType.values;
      if (typeInt < 0 || typeInt >= types.length) {
          return ContactType.errorType;
      }

      return ContactType.values[typeInt];
  }
}

enum ContactType {
    phone, email, website, fax, errorType
}