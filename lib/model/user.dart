class User {
  final String name;
  final int age;
  final String imgUrl;
  final String location;
  final String bio;
  bool isLiked;
  bool isSwipedOff;

  User({
    required this.name,
    required this.age,
    required this.imgUrl,
    required this.location,
    required this.bio,
    this.isLiked = false,
    this.isSwipedOff = false,
  });
}
