import 'package:cloud_firestore/cloud_firestore.dart';

class Swipe {
  int id;
  String sourceProfileEmail;
  int sourceProfileId;
  String sourceProfileFName;
  String sourceProfileLName;
  String swipeDate;
  String destinationProfileEmail;
  int destinationProfileId;
  String destinationProfileFName;
  String destinationProfileLName;
  String direction;

  Swipe({
    required this.id,
    required this.sourceProfileEmail,
    required this.sourceProfileId,
    required this.sourceProfileFName,
    required this.sourceProfileLName,
    required this.swipeDate,
    required this.destinationProfileEmail,
    required this.destinationProfileId,
    required this.destinationProfileFName,
    required this.destinationProfileLName,
    required this.direction,
  });

  Map<String, dynamic> toJson(Swipe swipeObject) => {
        'id': swipeObject.id,
        'sourceProfileEmail': swipeObject.sourceProfileEmail,
        'sourceProfileId': swipeObject.sourceProfileId,
        'sourceProfileFName': swipeObject.sourceProfileFName,
        'sourceProfileLName': swipeObject.sourceProfileLName,
        'swipeDate': swipeObject.swipeDate,
        'destinationProfileEmail': swipeObject.destinationProfileEmail,
        'destinationProfileId': swipeObject.destinationProfileId,
        'destinationProfileFName': swipeObject.destinationProfileFName,
        'destinationProfileLName': swipeObject.destinationProfileLName,
        'direction': swipeObject.direction,
      };

  static Swipe fromJson(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    return Swipe(
        id: data['id'],
        sourceProfileEmail: data['sourceProfileEmail'],
        sourceProfileId: data['sourceProfileId'],
        sourceProfileFName: data['sourceProfileFName'],
        sourceProfileLName: data['sourceProfileLName'],
        swipeDate: data['swipeDate'],
        destinationProfileEmail: data['destinationProfileEmail'],
        destinationProfileId: data['destinationProfileId'],
        destinationProfileFName: data['destinationProfileFName'],
        destinationProfileLName: data['destinationProfileLName'],
        direction: data['direction']);
  }
}
