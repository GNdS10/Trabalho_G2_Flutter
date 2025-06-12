import 'package:flutter/material.dart';
import '../models/book.dart';

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bookList.sort((a, b) => b.totalSecondsRead.compareTo(a.totalSecondsRead));

    return Scaffold(
      appBar: AppBar(title: Text('Ranking de Leitura')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: bookList.isEmpty
            ? Center(
                child: Text(
                  'Nenhum livro registrado ainda.\nVolte e adicione um!',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.separated(
                itemCount: bookList.length,
                separatorBuilder: (_, __) => Divider(),
                itemBuilder: (context, index) {
                  final book = bookList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple[100],
                      child: Text('${index + 1}', style: TextStyle(color: Colors.deepPurple)),
                    ),
                    title: Text(book.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    subtitle: Text('Tempo Lido: ${book.formattedTime}\n${book.medalsStr}'),
                    isThreeLine: true,
                  );
                },
              ),
      ),
    );
  }
}
