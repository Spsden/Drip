import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationModel {
  late String title;
  late IconData icon;

  NavigationModel({required this.title, required this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: 'Home', icon: Icons.home_rounded),
  NavigationModel(title: 'Search', icon: Icons.search_rounded),
  NavigationModel(title: 'Playlist', icon: Icons.playlist_add)
];
