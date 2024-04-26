class UserModel {
  String? name, email, password, phoneNumber, profileImageUri, userId;
  UserModel({
    this.name,
    this.email,
    this.password,
    this.profileImageUri,
    this.phoneNumber,
    this.userId,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      profileImageUri: map['profileImageUri'],
    );
  }
}
