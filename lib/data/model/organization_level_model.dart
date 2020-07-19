import 'package:equatable/equatable.dart';

class OrganizationLevelModel extends Equatable{
    final int id;
    final String name;
    final String description;
    final String icon;

  OrganizationLevelModel({this.id, this.name, this.description, this.icon});

  @override
  List<Object> get props => [id];
}