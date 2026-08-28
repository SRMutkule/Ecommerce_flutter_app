class AuthRepository {
  Future<bool> login(String email, String password) async {
    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<bool> signup(String name, String email, String password) async {
    return name.isNotEmpty && email.isNotEmpty && password.length >= 6;
  }
}
