class UserToSignup {
  String email;
  String name;
  String phoneNumber;
  String password;

  UserToSignup({
    this.email,
    this.name,
    this.phoneNumber,
    this.password,
  });
}

class UserToLogin {
  String email;
  String password;

  UserToLogin({
    this.email,
    this.password,
  });
}
