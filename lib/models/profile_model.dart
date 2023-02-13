import 'package:flutter/material.dart';

class ProfileModel {
  String name;
  String breed;
  String location;
  // List<Color> color;
  AssetImage image;

  ProfileModel({
    required this.name,
    required this.breed,
    required this.location,
    // required this.color,
    required this.image,
  });
}

final List<ProfileModel> candidates = [
  ProfileModel(
    name: 'Bruno',
    breed: 'Golden Retriever',
    location: 'Areado',
    image: const AssetImage('assets/images/dog1.jpg'),
    // color: const [Color(0xFFFF3868), Color(0xFFFFB49A)],
  ),
  ProfileModel(
    name: 'Tyson',
    breed: 'Pug',
    location: 'Seattle',
    image: const AssetImage('assets/images/dog2.jpg'), 
    // color: const [Color(0xFFFF3868), Color(0xFFFFB49A)],
  ),
  ProfileModel(
    name: 'Augiee',
    breed: 'Sheepadoodle',
    location: 'Samammish',
    image: const AssetImage('assets/images/dog3.jpg'),
    // color: const [Color(0xFF0BA4E0), Color(0xFFA9E4BD)],
  ),
  ProfileModel(
    name: 'Junior',
    breed: 'saint bernard',
    location: 'Bellevue',
    image: const AssetImage('assets/images/dog4.jpg'),
    // color: const [Color(0xFF0BA4E0), Color(0xFFA9E4BD)],
  ),
];