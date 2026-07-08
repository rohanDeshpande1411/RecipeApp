class AuthModel {
  final int id;

  final String username;

  final String accessToken;

  final String refreshToken;

  AuthModel(
      {required this.id,
      required this.username,
      required this.accessToken,
      required this.refreshToken});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
        id: json['id'],
        username: json['username'],
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken']);
  }
}
