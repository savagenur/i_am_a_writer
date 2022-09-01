import 'package:equatable/equatable.dart';

import '../../models/chapter.dart';
import '../bloc_exports.dart';

part 'chapters_event.dart';
part 'chapters_state.dart';

class ChaptersBloc extends HydratedBloc<ChaptersEvent, ChaptersState> {
  ChaptersBloc() : super(const ChaptersState()) {
    on<AddChapterEvent>(_onAddChapter);
    on<UpdateChapterEvent>(_onUpdateChapter);
    on<UpgradeChapterEvent>(_onUpgradeChapter);
    on<DeleteChapterEvent>(_onDeleteChapter);
    on<ContentCharachterCountEvent>(_onContentCount);
  }
  void _onAddChapter(AddChapterEvent event, Emitter<ChaptersState> emit) {
    final state = this.state;
    emit(
      ChaptersState(
        allChapters: List.of(state.allChapters)..add(event.chapter),
      ),
    );
  }

  void _onContentCount(
      ContentCharachterCountEvent event, Emitter<ChaptersState> emit) {
    final state = this.state;
    final allChapters = List.of(state.allChapters);

    final contentChar = event.content;
    emit(ChaptersState(contentChar: contentChar, allChapters: allChapters));
  }

  void _onUpgradeChapter(
      UpgradeChapterEvent event, Emitter<ChaptersState> emit) {
    final state = this.state;
    int index = List.of(state.allChapters).indexOf(event.chapter);
    final allChapters = List.of(state.allChapters)
      ..remove(event.chapter)
      // ..add(event.newChapter);
    ..insert(index, event.newChapter);
    emit(
      ChaptersState(
        allChapters: allChapters,
      ),
    );
  }

  void _onUpdateChapter(UpdateChapterEvent event, Emitter<ChaptersState> emit) {
    final state = this.state;
    final chapter = event.chapter;
    int index = state.allChapters.indexOf(chapter);
    List<Chapter> allChapters = List.from(state.allChapters)..remove(chapter);
    chapter.isDone == false
        ? allChapters.insert(index, chapter.copyWith(isDone: true))
        : allChapters.insert(index, chapter.copyWith(isDone: false));
    emit(ChaptersState(allChapters: allChapters));
  }

  void _onDeleteChapter(DeleteChapterEvent event, Emitter<ChaptersState> emit) {
    final state = this.state;
    final chapter = event.chapter;
    List<Chapter> allChapters = List.of(state.allChapters)..remove(chapter);

    emit(ChaptersState(allChapters: allChapters));
  }

  @override
  ChaptersState? fromJson(Map<String, dynamic> json) {
    return ChaptersState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ChaptersState state) {
    return state.toMap();
  }
}
