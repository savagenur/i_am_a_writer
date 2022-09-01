import 'package:equatable/equatable.dart';

class Chapter extends Equatable {
  String title;
  final String id;
  final String content;
  bool? isDone;
  bool? isDeleted;

  bool? isFavorite;

  Chapter({
    required this.title,
    required this.id,
    required this.content,
    this.isDone,
    this.isDeleted,
    this.isFavorite,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
  }

  Chapter copyWith({
    String? title,
    String? id,
    String? content,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Chapter(
      title: title ?? this.title,
      id: id ?? this.id,
      content: content ?? this.content,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'id': id});
    result.addAll({'content': content});
    if (isDone != null) {
      result.addAll({'isDone': isDone});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }
    if (isFavorite != null) {
      result.addAll({'isFavorite': isFavorite});
    }

    return result;
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      title: map['title'] == '' ? '<Untitled>' : map['title'] ?? '',
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
      isFavorite: map['isFavorite'],
    );
  }

  @override
  List<Object?> get props => [
        title,
        id,
        isDone,
        content,
        isDeleted,
        isFavorite,
      ];
}
