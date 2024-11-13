import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app_state.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 208, 187), // Warna latar belakang senada
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 175, 135),
        title: const Text('Favorites', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You Have ${appState.favorites.length} Favorite Words',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0C044A),
                  ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: appState.favorites.isNotEmpty
                  ? ListView.builder(
                      itemCount: appState.favorites.length,
                      itemBuilder: (context, index) {
                        var word = appState.favorites[index];
                        return Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            title: Text(
                              word.asLowerCase,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0C044A),
                              ),
                            ),
                            leading: const Icon(
                              Icons.favorite_outline_sharp,
                              color: Color(0xFFED0553),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_sweep,
                                color: Color(0xFFB7006D),
                              ),
                              onPressed: () {
                                appState.favorites.remove(word);
                                appState.notifyListeners();
                              },
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("It's ${word.asLowerCase}!"),
                                  backgroundColor: const Color.fromARGB(255, 255, 158, 84),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            onLongPress: () {
                              appState.favorites.remove(word);
                              appState.notifyListeners();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${word.asLowerCase} removed from favorites.",
                                  ),
                                  backgroundColor: const Color(0xFFB7006D),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No favorite words yet.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: const Color(0xFF0C044A),
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
