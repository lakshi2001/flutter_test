import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

enum UserState {
  initial,
  loading,
  success,
  error,
}

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository;

  UserState _state = UserState.initial;
  User? _user;
  String? _errorMessage;

  UserState get state => _state;
  User? get user => _user;
  String? get errorMessage => _errorMessage;

  UserProvider({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository();

  Future<void> fetchUser(String userId) async {
    _state = UserState.loading;
    notifyListeners();

    try {
      _user = await _userRepository.getUser(userId);
      _state = UserState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = UserState.error;
    }

    notifyListeners();
  }
}
