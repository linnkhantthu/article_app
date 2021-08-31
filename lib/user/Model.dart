class User{
  late final int user_id;
  late final String username;
  late final String email;

  User({
    required this.user_id,
    required this.username,
    required this.email
});
  factory User.fromJson(Map<String, dynamic> json){
    json = json["result"];
    return User(
      user_id: json["user_id"],
      username: json["username"],
      email: json["email"]
    );
  }

}