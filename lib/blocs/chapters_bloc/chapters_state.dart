part of 'chapters_bloc.dart';

class ChaptersState extends Equatable {
  final List<Chapter> allChapters;
  final int contentChar;
 
  const ChaptersState({
    this.allChapters = const <Chapter>[],
    this.contentChar = 0,
  });

  @override
  List<Object> get props => [allChapters,contentChar];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'allChapters': allChapters.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ChaptersState.fromMap(Map<String, dynamic> map) {
    return ChaptersState(
      allChapters: List<Chapter>.from(
          map['allChapters']?.map((x) => Chapter.fromMap(x))),
    );
  }
}


