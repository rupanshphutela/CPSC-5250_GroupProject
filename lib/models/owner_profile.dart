class OwnerProfile {
  int ownerId;
  String fName;
  String lName;
  String phone;
  String email;
  String? addressText;
  String? addressCoordindates;
  String picture;
  OwnerProfile({
    required this.ownerId,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email,
    this.addressText,
    this.addressCoordindates,
    required this.picture,
  });
}
