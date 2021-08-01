class JournalEntry {
  int? id;
  String title;
  String body;
  int rating;
  DateTime date;

  JournalEntry (this.id, this.title, this.body, this.rating, this.date);

  JournalEntry.fromMap(Map<String, dynamic> map) :
        id = map['id'],
        title = map['title'],
        body = map['body'],
        rating = map['rating'],
        date = map['date'] is DateTime ? map['date'] : DateTime.parse(map['date']);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': title,
      'body': body,
      'rating': rating,
      'date': date.toString(),
    };
    if(id != null) map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return 'JournalEntry{id: $id, title: $title, rating: $rating, date: $date,'
        'body:\n$body}';
  }
}