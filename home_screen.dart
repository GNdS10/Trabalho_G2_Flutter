import 'package:flutter/material.dart';
import '../models/book.dart';
import 'reading_timer_screen.dart';
import 'ranking_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bookNameController = TextEditingController();

  @override
  void dispose() {
    _bookNameController.dispose();
    super.dispose();
  }

  void _startReading() {
    if (_formKey.currentState!.validate()) {
      String name = _bookNameController.text.trim();
      Book? book = bookList.firstWhere(
        (b) => b.name.toLowerCase() == name.toLowerCase(),
        orElse: () => Book(name: name),
      );

      if (!bookList.contains(book)) {
        bookList.add(book);
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ReadingTimerScreen(book: book)),
      );
    }
  }

  void _goToRanking() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RankingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leitura Master'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Digite o nome do livro que você vai ler:',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 14),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _bookNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ex: O Senhor dos Anéis',
                      labelText: 'Nome do Livro',
                      prefixIcon: Icon(Icons.book),
                    ),
                    validator: (val) =>
                        (val == null || val.trim().isEmpty) ? 'Digite um nome' : null,
                    onFieldSubmitted: (_) => _startReading(),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: Icon(Icons.play_arrow),
                  label: Text('Começar Leitura', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: _startReading,
                ),
                SizedBox(height: 30),
                Divider(),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.leaderboard),
                  label: Text('Ver Ranking dos Livros', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 42),
                    backgroundColor: Colors.deepPurple[300],
                  ),
                  onPressed: _goToRanking,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
