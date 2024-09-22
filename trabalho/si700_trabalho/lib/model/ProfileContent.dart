class ProfileContent {
  static ProfileContent? self;

  final String profileIcon;
  final String name;
  final String email;
  final String phone;
  final String password;
  final bool receiveNotifications;
  final List<String> favoritePlaces;

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
}
