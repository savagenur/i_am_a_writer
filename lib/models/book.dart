import 'package:equatable/equatable.dart';

import 'package:i_am_a_writer/models/chapter.dart';

class Book extends Equatable {
  final String title;
  final String id;
  final List<Chapter> chapters;

  bool? isSelected;
  bool? isExpanded;

  bool? isFavorite;
  Book({
    required this.title,
    required this.id,
    required this.chapters,
    this.isSelected,
    this.isExpanded,
    this.isFavorite,
  }) {
    isSelected = isSelected ?? false;
    isExpanded = isExpanded ?? false;
    isFavorite = isFavorite ?? false;
  }

  Book copyWith({
    String? title,
    String? id,
    List<Chapter>? chapters,
    bool? isSelected,
    bool? isExpanded,
    bool? isFavorite,
  }) {
    return Book(
      title: title ?? this.title,
      id: id ?? this.id,
      chapters: chapters ?? this.chapters,
      isSelected: isSelected ?? this.isSelected,
      isExpanded: isExpanded ?? this.isExpanded,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'id': id});
    result.addAll({'chapters': chapters.map((x) => x.toMap()).toList()});
    if (isSelected != null) {
      result.addAll({'isSelected': isSelected});
    }
    if (isExpanded != null) {
      result.addAll({'isExpanded': isExpanded});
    }
    if (isFavorite != null) {
      result.addAll({'isFavorite': isFavorite});
    }

    return result;
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      chapters:
          List<Chapter>.from(map['chapters']?.map((x) => Chapter.fromMap(x))),
      isSelected: map['isSelected'],
      isExpanded: false,
      isFavorite: map['isFavorite'],
    );
  }
  @override
  List<Object?> get props => [
        title,
        chapters,
        id,
        // isExpanded,
        isSelected,
        isFavorite,
      ];
}
