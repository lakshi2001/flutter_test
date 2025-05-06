import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// TODO: Refactor this class according to Part 3 requirements
// Requirements:
// - Extract data fetching logic into a separate layer (Repository or Service)
// - Replace setState with Provider (ChangeNotifierProvider)
// - Inject dependencies using Provider
// - Implement robust error handling
// - Create a User model class to represent data instead of Map<String, dynamic>
// - Improve overall structure, readability, and maintainability

class UserProfileScreen extends StatefulWidget {
  final String userId;
  const UserProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Map<String, dynamic>? _userData;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _userData = null;
    });
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/${widget.userId}'));

      if (!mounted) return; // Check if widget is still mounted

      if (response.statusCode == 200) {
         setState(() {
           _userData = jsonDecode(response.body);
           _isLoading = false;
         });
      } else {
        setState(() {
          _error = 'Failed to load user data. Status Code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
       if (!mounted) return;
       setState(() {
         _error = 'An error occurred: ${e.toString()}';
         _isLoading = false;
       });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _error != null
                ? Text('Error: $_error', style: const TextStyle(color: Colors.red))
                : _userData != null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${_userData!['name'] ?? 'N/A'}', style: Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: 8),
                            Text('Email: ${_userData!['email'] ?? 'N/A'}'),
                            const SizedBox(height: 8),
                            Text('Phone: ${_userData!['phone'] ?? 'N/A'}'),
                            const SizedBox(height: 8),
                            Text('Website: ${_userData!['website'] ?? 'N/A'}'),
                          ],
                        ),
                      )
                    : const Text('No user data found.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchUserData, // Re-fetch data
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
