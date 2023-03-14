import 'package:flutter_test/flutter_test.dart';
import 'package:the_dig_app/models/contact.dart';

void main() {
  group('Contact model', () {
    final contact = Contact(
      id: 1,
      email: 'test@test.com',
      profileId: 1,
      fName: 'John',
      lName: 'Doe',
      connectionSince: '2022-01-01',
      destinationProfileId: 2,
      destinationFName: 'Jane',
      destinationLName: 'Doe',
      destinationEmail: 'jane@test.com',
      destinationBreed: 'Golden Retriever',
      destinationColor: 'Golden',
    );

    test('toJson method should return a valid JSON map', () {
      final jsonMap = contact.toJson(contact);
      expect(jsonMap, isA<Map<String, dynamic>>());
      expect(jsonMap['id'], equals(contact.id));
      expect(jsonMap['email'], equals(contact.email));
      expect(jsonMap['profileId'], equals(contact.profileId));
      expect(jsonMap['fName'], equals(contact.fName));
      expect(jsonMap['lName'], equals(contact.lName));
      expect(jsonMap['connectionSince'], equals(contact.connectionSince));
      expect(jsonMap['destinationProfileId'],
          equals(contact.destinationProfileId));
      expect(jsonMap['destinationFName'], equals(contact.destinationFName));
      expect(jsonMap['destinationLName'], equals(contact.destinationLName));
      expect(jsonMap['destinationEmail'], equals(contact.destinationEmail));
      expect(jsonMap['destinationBreed'], equals(contact.destinationBreed));
      expect(jsonMap['destinationColor'], equals(contact.destinationColor));
    });
  });
}
