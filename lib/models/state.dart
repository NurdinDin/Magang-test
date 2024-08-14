import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'user.dart';

class StateApp with ChangeNotifier {
  String _name = '';
  String _selectedUserName = '';

  String get name => _name;
  String get selectedUserName => _selectedUserName;

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateSelectedUserName(String newName) {
    _selectedUserName = newName;
    notifyListeners();
  }

  List<User> _users = [];
  int _currentPage = 1;
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> fetchUsers() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$_currentPage'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<User> fetchedUsers = (data['data'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList();

      _users.addAll(fetchedUsers);
      _currentPage++;
    } else {
      throw Exception('Failed to load users');
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectUser(User user) {
    _selectedUserName = '${user.firstName} ${user.lastName}';
    notifyListeners();
  }
}