import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intership_suitmedia/models/user_model.dart';

class AppState extends ChangeNotifier {
  String _name = '';
  String _selectedUserName = '';
  List<User> _users = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  bool _hasMoreData = true;

  String get name => _name;
  String get selectedUserName => _selectedUserName;
  List<User> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setSelectedUserName(String userName) {
    _selectedUserName = userName;
    notifyListeners();
  }

  void setUsers(List<User> users) {
    _users = users;
    notifyListeners();
  }

  void addUsers(List<User> users) {
    _users.addAll(users);
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void resetUsers() {
    _users = [];
    _currentPage = 1;
    _hasMoreData = true;
    notifyListeners();
  }

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _hasMoreData = true;
    }

    if (!_hasMoreData) return;

    setLoading(true);
    
    try {
      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$_currentPage&per_page=10'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<User> newUsers = (data['data'] as List)
            .map((user) => User.fromJson(user))
            .toList();

        _totalPages = data['total_pages'];
        
        if (isRefresh) {
          setUsers(newUsers);
        } else {
          addUsers(newUsers);
        }

        _currentPage++;
        _hasMoreData = _currentPage <= _totalPages;
      }
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      setLoading(false);
    }
  }
}