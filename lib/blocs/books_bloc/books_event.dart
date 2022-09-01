part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();

  @override
  List<Object> get props => [];
}

class AddBookEvent extends BooksEvent {
  final Book book;
  AddBookEvent({
    required this.book,
  });
  @override
  List<Object> get props => [book];
}

class RenameBookEvent extends BooksEvent {
  final Book book;
  final Book renamedBook;
  RenameBookEvent({
    required this.book,
    required this.renamedBook,
  });
  @override
  List<Object> get props => [book,renamedBook];
}

class UpdateBookEvent extends BooksEvent {
  final Book book;
  UpdateBookEvent({
    required this.book,
  });
  @override
  List<Object> get props => [book];
}

class DeleteBookEvent extends BooksEvent {
  final Book book;
  DeleteBookEvent({
    required this.book,
  });
  List<Object> get props => [book];
}

class RemoveBookEvent extends BooksEvent {
  final Book book;
  RemoveBookEvent({
    required this.book,
  });
  List<Object> get props => [book];
}

class RefreshBookEvent extends BooksEvent {
  final Book book;
  RefreshBookEvent({
    required this.book,
  });
  List<Object> get props => [book];
}

class AddBookChapterEvent extends BooksEvent {
  final Book book;
  final Chapter chapter;
  AddBookChapterEvent({
    required this.book,
    required this.chapter,
  });
  List<Object> get props => [book, chapter];
}
