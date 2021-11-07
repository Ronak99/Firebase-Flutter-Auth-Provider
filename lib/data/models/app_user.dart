import 'dart:convert';

class AppUser {
  String uid;
  String name;
  String email;
  String? profilePic;
  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.profilePic,
  });

  AppUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? profilePic,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profile_pic': profilePic,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      profilePic: map['profilePic'] != null ? map['profile_pic'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(uid: $uid, name: $name, email: $email, profile_pic: $profilePic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.profilePic == profilePic;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ name.hashCode ^ email.hashCode ^ profilePic.hashCode;
  }
}
