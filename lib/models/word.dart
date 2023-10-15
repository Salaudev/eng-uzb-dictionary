class Word {
  final int id;
  final String english;
  final String type;
  final String transcript;
  final String uzbek;
  final String? countable;
  final int is_favourite;
  final int? is_favourite_uzb;

  const Word({
    required this.id,
    required this.english,
    required this.type,
    required this.transcript,
    required this.uzbek,
    required this.countable,
    required this.is_favourite,
    required this.is_favourite_uzb,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'english': english,
      'type': type,
      'transcript': transcript,
      'uzbek': uzbek,
      'countable': countable,
      'is_favourite': is_favourite,
      'is_favourite_uzb': is_favourite_uzb,
    };
  }
}