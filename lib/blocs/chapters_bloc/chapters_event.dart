part of 'chapters_bloc.dart';

abstract class ChaptersEvent extends Equatable {
  const ChaptersEvent();

  @override
  List<Object> get props => [];
}
 
class AddChapteREvent extends ChaptersEvent {
  final Chapter chapter;
  const AddChapteREvent({
    required this.chapter,
  });

  @override
  List<Object> get props => [
        chapter,
      ];
}

class UpdateChapterEvent extends ChaptersEvent {
  final Chapter chapter;
  const UpdateChapterEvent({
    required this.chapter,
  });

  @override
  List<Object> get props => [
        chapter,
      ];
}

class UpgradeChapterEvent extends ChaptersEvent {
  final Chapter chapter;
  final Chapter newChapter;
  const UpgradeChapterEvent({
    required this.chapter,
    required this.newChapter,
  });

  @override
  List<Object> get props => [
        chapter,
        newChapter,
      ];
}

class DeleteChapteREvent extends ChaptersEvent {
  final Chapter chapter;
  const DeleteChapteREvent({
    required this.chapter,
  });

  @override
  List<Object> get props => [
        chapter,
      ];
}

class ContentCharachterCountEvent extends ChaptersEvent {
  final int content;
  const ContentCharachterCountEvent({
    required this.content,
  });

  @override
  List<Object> get props => [
        content,
      ];
}
