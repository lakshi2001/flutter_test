// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchProvider>().updateSearchQuery(query);
              },
              decoration: const InputDecoration(
                labelText: 'Search for products',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),

            Consumer<SearchProvider>(
              builder: (context, provider, _) {
                if (provider.state == SearchState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.state == SearchState.error) {
                  return Center(child: Text('Error: ${provider.errorMessage}'));
                }

                if (provider.state == SearchState.empty) {
                  return const Center(child: Text('No results found.'));
                }

                if (provider.state == SearchState.success) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: provider.results.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(provider.results[index]));
                      },
                    ),
                  );
                }

                return const Center(
                  child: Text('Start searching for products.'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
