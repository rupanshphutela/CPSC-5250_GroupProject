import 'package:floor/floor.dart';

@Entity(tableName: 'owner_profile')
class Owner {
  @primaryKey
  int id;
  String fName;
  String lName;
  String phone;
  String email;
  String? addressText;
  String? addressCoordindates;
  String picture;
  Owner({
    required this.id,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    this.addressText,
    this.addressCoordindates,
    required this.picture,
  });
}
