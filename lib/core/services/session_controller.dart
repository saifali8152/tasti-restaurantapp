import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../features/auth/data/models/user.dart';
import '../../features/auth/domain/entities/user.dart';
import 'local_storage.dart';

class SessionController {
  static final SessionController _instance = SessionController._internal();
  factory SessionController() => _instance;
  SessionController._internal();

  final LocalStorage _localStorage = LocalStorage();

  UserEntity? _user;
  bool _isFirstVisit = true;

  UserEntity? get user => _user;
  bool get isFirstVisit => _isFirstVisit;

  Future<void> loadSession() async {
    try {
      final userData = await _localStorage.readValue('user');
      final firstVisitStr = await _localStorage.readValue('isFirstVisit');

      _isFirstVisit = firstVisitStr != 'false';

      if (userData != null) {
        final userModel = UserModel.fromJson(jsonDecode(userData));
        _user = userModel.toEntity();
      } else {
        _user = null;
      }
    } catch (e) {
      debugPrint('Session load error: $e');
    }
  }

  Future<void> saveUserSession(UserEntity user) async {
    try {
      _user = user;
      _isFirstVisit = false;
      final userModel = UserModel.fromEntity(user);
      await _localStorage.setValue('user', jsonEncode(userModel.toJson()));
      await _localStorage.setValue('isLogin', 'true');
      await setFirstVisit();
      debugPrint('User session saved: ${userModel.toJson()}');
    } catch (e) {
      debugPrint('Save session error: $e');
    }
  }

  Future<void> setFirstVisit() async {
    _isFirstVisit = false;
    await _localStorage.setValue('isFirstVisit', 'false');
  }

  Future<void> clearSession() async {
    try {
      await _localStorage.clearValue('user');
      await _localStorage.clearValue('isFirstVisit');
      _user = null;
      debugPrint('Session cleared');
    } catch (e) {
      debugPrint('Error clearing session: $e');
    }
  }
}
