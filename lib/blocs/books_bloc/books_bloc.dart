import 'package:equatable/equatable.dart';
import 'package:i_am_a_writer/models/chapter.dart';

import '../../models/book.dart';
import '../bloc_exports.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends HydratedBloc<BooksEvent, BooksState> {
  BooksBloc() : super(BooksState()) {
    on<AddBookEvent>(_onAddBook);
    on<UpdateBookEvent>(_onUpdateBook);
    on<DeleteBookEvent>(_onDeleteBook);
    on<RemoveBookEvent>(_onRemoveBook);

    on<AddBookChapterEvent>(_onAddBookChapter);
    on<RefreshBookEvent>(_onRefreshBook);
    on<RenameBookEvent>(_onRenameBook);
  }

  void _onAddBook(AddBookEvent event, Emitter<BooksState> emit) {
    final state = this.state;
    final allBooks = List.of(state.allBooks)..add(event.book);
    emit(BooksState(allBooks: allBooks));
  }

  void _onRefreshBook(RefreshBookEvent event, Emitter<BooksState> emit) {
    final state = this.state;
    final book = event.book;
    final allBooks = List.of(state.allBooks);

    emit(BooksState(allBooks: allBooks));
  }

  void _onUpdateBook(UpdateBookEvent event, Emitter<BooksState> emit) {}
  void _onDeleteBook(DeleteBookEvent event, Emitter<BooksState> emit) {
    final state = this.state;
    final allBooks = List.of(state.allBooks)..remove(event.book);
    emit(BooksState(allBooks: allBooks));
  }

  void _onRemoveBook(RemoveBookEvent event, Emitter<BooksState> emit) {}

  void _onAddBookChapter(AddBookChapterEvent event, Emitter<BooksState> emit) {
    final state = this.state;
    
    final chapter = event.book.chapters.add(event.chapter);
    emit(BooksState(allBooks: List.of(state.allBooks)));
  }

  void _onRenameBook(RenameBookEvent event, Emitter<BooksState> emit) {
    final state = this.state;
    final book = event.book;
    final renamedBook = event.renamedBook;
    int index = List.of(state.allBooks).indexOf(book);
    final allBooks = List.of(state.allBooks)
      ..remove(book)
      ..insert(index, renamedBook);

    emit(BooksState(allBooks: allBooks));
  }

  @override
  BooksState? fromJson(Map<String, dynamic> json) {
    return BooksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(BooksState state) {
    return state.toMap();
  }
}
