import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app_state.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 208, 187), 
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 179, 134), // Warna latar belakang AppBar yang konsisten
        title: const Text('History', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History Words',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0C044A),
                      ),
                ),
                TextButton(
                  onPressed: () {
                    appState.history.clear();
                    appState.notifyListeners();
                  },
                  child: const Text(
                    'Delete forever',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFB7006D),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: appState.history.isNotEmpty
                  ? ListView.builder(
                      itemCount: appState.history.length,
                      itemBuilder: (context, index) {
                        var word = appState.history[index];
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
                              Icons.history,
                              color: Color(0xFF0D9D57),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xFFB7006D),
                              ),
                              onPressed: () {
                                appState.history.remove(word);
                                appState.notifyListeners();
                              },
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Word: ${word.asLowerCase}"),
                                  backgroundColor: const Color(0xFF0074B7),
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
                        'No history words yet.',
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
