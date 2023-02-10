final List<Profile> demoProfiles = [
  new Profile(
    photos: [
      "assets/photo_1.jpg",
      "assets/photo_4.jpg",
    ],
    name: "Benji",
    bio: "Part time frog",
  ),
  new Profile(
    photos: [
      "assets/photo_3.jpg",
      "assets/photo_2.jpg",
    ],
    name: "Still Benji",
    bio: "I like to look outside",
  ),
];

class Profile {
  final List<String> photos;
  final String name;
  final String bio;

  Profile({this.photos, this.name, this.bio});
}
