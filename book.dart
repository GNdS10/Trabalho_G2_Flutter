class Book {
  String name;
  int totalSecondsRead;
  Set<String> medals = {};

  Book({required this.name, this.totalSecondsRead = 0});

  String get medalsStr {
    if (medals.isEmpty) return 'Sem medalhas';
    return medals.join(' • ');
  }

  String get formattedTime {
    int h = totalSecondsRead ~/ 3600;
    int m = (totalSecondsRead % 3600) ~/ 60;
    int s = totalSecondsRead % 60;
    if (h > 0) return '${h}h ${m}m';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }
}

// Estado global simulado
List<Book> bookList = [];
