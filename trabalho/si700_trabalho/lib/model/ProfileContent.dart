class ProfileContent {
  static ProfileContent? self;

  String profileIcon;
  final String name;
  final String email;
  final String phone;
  final String password;
  final bool receiveNotifications;
  final List<dynamic> favoritePlaces;

  ProfileContent({
    required this.profileIcon,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.receiveNotifications,
    this.favoritePlaces = const [],
  });

  ProfileContent.fromAnother(
      {required ProfileContent another,
      required String name,
      required String email,
      required String phone})
      : profileIcon = another.profileIcon,
        password = another.password,
        favoritePlaces = another.favoritePlaces,
        receiveNotifications = another.receiveNotifications,
        name = (name.isEmpty) ? another.name : name,
        email = (email.isEmpty) ? another.email : email,
        phone = (phone.isEmpty) ? another.phone : phone;

  static fromMap(map) {
    return ProfileContent(
      profileIcon: map["profileIcon"],
      name: map["name"],
      email: map["email"],
      phone: map["phone"],
      password: "",
      receiveNotifications: map["receiveNotifications"],
      favoritePlaces: map["favoritePlaces"],
    );
  }

  toMap() {
    var map = <String, dynamic>{};
    map["profileIcon"] = profileIcon;
    map["name"] = name;
    map["email"] = email;
    map["phone"] = phone;
    map["receiveNotifications"] = receiveNotifications;
    map["favoritePlaces"] = favoritePlaces;
    return map;
  }
}
