import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../features/auth/data/model/user_model.dart';
import 'local_storage.dart';

class SessionController {
  static final SessionController _instance = SessionController._internal();
  factory SessionController() => _instance;
  SessionController._internal();

  final LocalStorage _localStorage = LocalStorage();

  UserModel _user = UserModel();
  bool _isDarkMode = false;
  String _languageCode = 'en';
  bool _providerMode = false;
  bool _isLogin = false;
  bool _isFirstVisit = true;
  bool _isAuthSkipped = false;
  Map<String, dynamic> _rememberMeData = {};

  UserModel get user => _user;
  bool get isDarkMode => _isDarkMode;
  bool get providerMode => _providerMode;
  String get languageCode => _languageCode;
  bool get isLogin => _isLogin;
  bool get isFirstVisit => _isFirstVisit;
  bool get isAuthSkipped => _isAuthSkipped;
  Map<String, dynamic> get rememberMeData => _rememberMeData;

  Future<void> loadSession() async {
    try {
      final darkModeStr = await _localStorage.readValue('isDarkMode');
      final langCode = await _localStorage.readValue('languageCode');
      final providerMode = await _localStorage.readValue('providerMode');

      final userData = await _localStorage.readValue('user');
      final isLoginStr = await _localStorage.readValue('isLogin');
      final rememberMeStr = await _localStorage.readValue('rememberMeData');
      final firstVisitStr = await _localStorage.readValue('isFirstVisit');
      final isAuthSkippedStr = await _localStorage.readValue('isAuthSkipped');

      _isDarkMode = darkModeStr == 'false';
      _providerMode = providerMode ?? 'false';
      _languageCode = langCode ?? 'en';

      _user = userData != null
          ? UserModel.fromJson(jsonDecode(userData))
          : const UserModel();
      _isLogin = isLoginStr == 'true';
      _isFirstVisit = firstVisitStr != 'false';
      _isAuthSkipped = isAuthSkippedStr == 'true';
      _rememberMeData = rememberMeStr != null ? jsonDecode(rememberMeStr) : {};
    } catch (e) {
      debugPrint('Session load error: $e');
    }
  }

  Future<void> setDarkMode(bool isDark) async {
    _isDarkMode = isDark;
    await _localStorage.setValue('isDarkMode', isDark.toString());
  }
  
  Future<void> setProviderMode(bool providerMode) async {
    _providerMode = providerMode;
    await _localStorage.setValue('providerMode', providerMode.toString());
  }

  Future<void> setLanguage(String code) async {
    _languageCode = code;
    await _localStorage.setValue('languageCode', code);
  }

  Future<void> saveUserSession(UserModel user) async {
    try {
      _user = user;
      _isLogin = true;
      _isFirstVisit = false;
      await _localStorage.setValue('user', jsonEncode(user));
      await _localStorage.setValue('isLogin', 'true');
      await _localStorage.setValue('isFirstVisit', 'false');
      debugPrint('User session saved: $user');
    } catch (e) {
      debugPrint('Save session error: $e');
    }
  }

  Future<void> skipAuth() async {
    try {
      await _localStorage.setValue('isAuthSkipped', 'true');
      await _localStorage.setValue('isFirstVisit', 'false');
      debugPrint('auth skipped: $user');
    } catch (e) {
      debugPrint('auth skipped error: $e');
    }
  }

  Future<void> saveRememberMe(Map<String, dynamic> data) async {
    _rememberMeData = data;
    await _localStorage.setValue('rememberMeData', jsonEncode(data));
  }

  Future<void> clearSession() async {
    try {
      await _localStorage.clearValue('user');
      await _localStorage.clearValue('isLogin');
      await _localStorage.clearValue('isAuthSkipped');
      await _localStorage.clearValue('rememberMeData');
      _user = UserModel.fromJson(const {});
      _isLogin = false;
      _rememberMeData = {};
      debugPrint('Session cleared');
    } catch (e) {
      debugPrint('Error clearing session: $e');
    }
  }
}