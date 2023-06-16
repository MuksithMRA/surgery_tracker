class UserService {
  Future<String> getUser() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'User';
  }
}
