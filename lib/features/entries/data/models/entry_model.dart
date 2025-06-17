class Entry {
  final int? id;
  final String category;
  final String item;
  final String date;
  final String location;
  final double price;

  Entry({
    this.id,
    required this.category,
    required this.item,
    required this.date,
    required this.location,
    required this.price,
  });

  // Convert from Map (Database) to Entry object
  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      id: map['id'] as int?,
      category: map['category'] as String,
      item: map['item'] as String,
      date: map['date'] as String,
      location: map['location'] as String,
      price: (map['price'] as num).toDouble(),
    );
  }

  // Convert from Entry object to Map (for Database)
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,  // Include ID only when updating
      'category': category,
      'item': item,
      'date': date,
      'location': location,
      'price': price,
    };
  }
}
