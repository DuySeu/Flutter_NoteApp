class Notes {
  String noteTitle;
  DateTime creationDate;
  String noteContent;
  String id;
  int colorId;

  Notes({
    required this.noteTitle,
    required this.noteContent,
    required this.creationDate,
    required this.id,
    required this.colorId,
  });

  Notes.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as String,
          noteTitle: json['noteTitle'] as String,
          creationDate: json['creationDate'] as DateTime,
          noteContent: json['noteContent'] as String,
          colorId: json['colorId'] as int,
        );
}
