// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'dart:convert';

class Profile {
  const Profile({
    this.username,
    this.emailAddress,
    this.phoneNumber,
    this.photoUrl,
    this.followingsCount,
    this.followersCount,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      username: map['username'] as String?,
      emailAddress: map['emailAddress'] as String?,
      phoneNumber: map['phoneNumber'] as String,
      photoUrl: map['photoUrl'] as String?,
      followingsCount:
          map['followingsCount'] != null ? map['followingsCount'] as int? : 0,
      followersCount:
          map['followersCount'] != null ? map['followersCount'] as int? : 0,
    );
  }

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  final String? username;
  final String? emailAddress;
  final String? phoneNumber;
  final String? photoUrl;
  final int? followingsCount;
  final int? followersCount;

  Profile copyWith({
    String? username,
    String? emailAddress,
    String? phoneNumber,
    String? photoUrl,
    int? followingsCount,
    int? followersCount,
  }) {
    return Profile(
      username: username ?? this.username,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      followingsCount: followingsCount ?? this.followingsCount,
      followersCount: followersCount ?? this.followersCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'followingsCount': followingsCount,
      'followersCount': followersCount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Profile(username: $username, emailAddress: $emailAddress, phoneNumber: $phoneNumber, photoUrl: $photoUrl, followingsCount: $followingsCount, followersCount: $followersCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.username == username &&
        other.emailAddress == emailAddress &&
        other.phoneNumber == phoneNumber &&
        other.photoUrl == photoUrl &&
        other.followingsCount == followingsCount &&
        other.followersCount == followersCount;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        emailAddress.hashCode ^
        phoneNumber.hashCode ^
        photoUrl.hashCode ^
        followingsCount.hashCode ^
        followersCount.hashCode;
  }
}
