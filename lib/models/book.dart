
import 'package:equatable/equatable.dart';

import 'package:i_am_a_writer/models/chapter.dart';

class Book extends Equatable {
  final String title;
  final String id;
  final List<Chapter> chapters;

  bool? isDone;
  bool? isDeleted;

  bool? isFavorite;
  Book({
    required this.title,
    required this.id,
    required this.chapters,
    this.isDone,
    this.isDeleted,
    this.isFavorite,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
  }

  Book copyWith({
    String? title,
    String? id,
    List<Chapter>? chapters,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Book(
      title: title ?? this.title,
      id: id ?? this.id,
      chapters: chapters ?? this.chapters,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'title': title});
    result.addAll({'id': id});
    result.addAll({'chapters': chapters.map((x) => x.toMap()).toList()});
    if(isDone != null){
      result.addAll({'isDone': isDone});
    }
    if(isDeleted != null){
      result.addAll({'isDeleted': isDeleted});
    }
    if(isFavorite != null){
      result.addAll({'isFavorite': isFavorite});
    }
  
    return result;
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      chapters: List<Chapter>.from(map['chapters']?.map((x) => Chapter.fromMap(x))),
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
      isFavorite: map['isFavorite'],
    );
  }
  @override
  List<Object?> get props => [
        title,
        chapters,
        id,
        isDeleted,
        isDone,
        isFavorite,
      ];


}
