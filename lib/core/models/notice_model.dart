class NoticeModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime date;
  final bool isVerified;
  final String? attachmentUrl;

  NoticeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.isVerified,
    this.attachmentUrl,
  });

  factory NoticeModel.fromMap(Map<String, dynamic> map, String id) {
    return NoticeModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      isVerified: map['isVerified'] ?? false,
      attachmentUrl: map['attachmentUrl'],
    );
  }
}
