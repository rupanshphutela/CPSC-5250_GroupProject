import 'package:floor/floor.dart';

@Entity(tableName: 'owner_profile')
class Owner {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String fName;
  String lName;
  String phone;
  String email;
  String? addressText;
  String? addressCoordindates;
  String picture;
  Owner({
    this.id,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    this.addressText,
    this.addressCoordindates,
    required this.picture,
  });

  toJson(){
    return {
      "fName": fName,
      "lName": lName,
      "phone": phone,
      "email": email,
      "addressText": addressText,
    };
  }
}
