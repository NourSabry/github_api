// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:github_api/widgets/repo_info.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/github_api.dart';

class Repos with ChangeNotifier {
  List<GithubServices> _repos = [];

  List<GithubServices> get repos {
    return [..._repos];
  }

  Future<void> fetchRepos() async {
    var url = Uri.parse('https://api.github.com/users/square/repos');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List<dynamic>?;
      final List<GithubServices> repos = [];
      // print(extractedData);
      for (var repo in extractedData!) {
        repos.insert(0, GithubServices.fromJson(repo));
      }
      // print(repos[1].name);

      _repos = repos;
      notifyListeners();

    } catch (e) {
      print(e.toString());
    }
  }
}
