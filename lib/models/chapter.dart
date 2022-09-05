import 'package:equatable/equatable.dart';

class Chapter extends Equatable {
  String title;
  final String id;
  final String content;
  final String dateTime;
   int? wordsCount;
  bool? isSelected;
  bool? isExpanded;

  bool? isFavorite;

  Chapter({
    required this.title,
    required this.dateTime,
    required this.id,
    required this.content,
    this.isSelected,
    this.wordsCount,
    this.isExpanded,
    this.isFavorite,
  }) {
    isSelected = isSelected ?? false;
    wordsCount = wordsCount ?? 0;
    isExpanded = isExpanded ?? false;
    isFavorite = isFavorite ?? false;
  }

  Chapter copyWith({
    String? title,
    String? dateTime,
    String? id,
    String? content,
    bool? isSelected,
    int? wordsCount,
    bool? isExpanded,
    bool? isFavorite,
  }) {
    return Chapter(
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      id: id ?? this.id,
      content: content ?? this.content,
      isSelected: isSelected ?? this.isSelected,
      wordsCount: wordsCount ?? this.wordsCount,
      isExpanded: isExpanded ?? this.isExpanded,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'dateTime': dateTime});
    result.addAll({'id': id});
    result.addAll({'content': content});
    if (isSelected != null) {
      result.addAll({'isSelected': isSelected});
    }
    if (wordsCount != null) {
      result.addAll({'wordsCount': wordsCount});
    if (isExpanded != null) {
      result.addAll({'isExpanded': isExpanded});
    }
    }
    if (isFavorite != null) {
      result.addAll({'isFavorite': isFavorite});
    }

    return result;
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      title: map['title'] == '' ? '<Untitled>' : map['title'] ?? '',
      dateTime: map['dateTime'] ?? '',
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      isSelected: map['isSelected'],
      wordsCount: map['wordsCount'],
      isExpanded: map['isExpanded'],
      isFavorite: map['isFavorite'],
    );
  }

  @override
  List<Object?> get props => [
        title,
        dateTime,
        id,
        isSelected,
        wordsCount,
        content,
        isExpanded,
        isFavorite,
      ];
}
