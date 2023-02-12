import 'package:flutter/material.dart';

class ProfileModel {
  String name;
  String breed;
  String location;
  List<Color> color;

  ProfileModel({
    required this.name,
    required this.breed,
    required this.location,
    required this.color,
  });
}

final List<ProfileModel> candidates = [
  ProfileModel(
    name: 'Bruno',
    breed: 'Golden Retriever',
    location: 'Areado',
    color: const [Color(0xFFFF3868), Color(0xFFFFB49A)],
  ),
  ProfileModel(
    name: 'Tyson',
    breed: 'Pug',
    location: 'Seattle',
    color: const [Color(0xFFFF3868), Color(0xFFFFB49A)],
  ),
  ProfileModel(
    name: 'Augy',
    breed: 'Sheepadoodle',
    location: 'Samammish',
    color: const [Color(0xFF0BA4E0), Color(0xFFA9E4BD)],
  ),
  ProfileModel(
    name: 'Junior',
    breed: 'saint bernard',
    location: 'Bellevue',
    color: const [Color(0xFF0BA4E0), Color(0xFFA9E4BD)],
  ),
];