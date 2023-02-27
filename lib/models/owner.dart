import 'package:cloud_firestore/cloud_firestore.dart';
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

  toJson() {
    return {
      "fName": fName,
      "lName": lName,
      "phone": phone,
      "email": email,
      "addressText": addressText,
    };
  }

  static Owner fromJson(QueryDocumentSnapshot data) {
    return Owner(
        id: data['id'],
        addressText: data['addressText'],
        email: data['email'],
        fName: data['fName'],
        lName: data['lName'],
        phone: data['phone'],
        picture: data['picture']);
  }
}
