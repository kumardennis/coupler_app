class UserModel {
  final int id;
  final String created_at;
  final String firstName;
  final String lastName;
  final String name;
  final String? profileImage;
  final String userId;
  final String? phone;
  final String? email;
  final String accessToken;
  final String shareableUuid;

  UserModel(
      this.id,
      this.created_at,
      this.firstName,
      this.lastName,
      this.name,
      this.profileImage,
      this.userId,
      this.email,
      this.phone,
      this.accessToken,
      this.shareableUuid);
}
