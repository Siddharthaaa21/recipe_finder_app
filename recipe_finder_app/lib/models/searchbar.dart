import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(SearchApp());
}

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Search',
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _apiKey = '54299d9868msh2a6fe2351947a85p1e3ab6jsn7925dc942ac8';
  String _apiHost = 'yummly2.p.rapidapi.com';

  Future<void> _searchRecipes() async {
    final String query = _searchController.text;
    final String path =
        '/feeds/search?start=0&maxResult=18&maxTotalTimeInSeconds=7200&q=$query&allowedAttribute=diet-lacto-vegetarian%2Cdiet-low-fodmap&FAT_KCALMax=1000';

    final Uri uri = Uri.https(_apiHost, path);
    final Map<String, String> headers = {
      'x-rapidapi-key': _apiKey,
      'x-rapidapi-host': _apiHost,
    };

    final http.Response response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      // Handle the response data as needed
      print(data);
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter your search query',
              ),
              onChanged: (String value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _searchRecipes();
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
