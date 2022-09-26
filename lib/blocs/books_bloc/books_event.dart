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
}

class RenameBookEvent extends BooksEvent {
  final Book book;
  final Book renamedBook;
  RenameBookEvent({
    required this.book,
    required this.renamedBook,
  });
}

class UpdateBookEvent extends BooksEvent {
  final Book book;
  UpdateBookEvent({
    required this.book,
  });
}

class DeleteBookEvent extends BooksEvent {
  final Book book;
  DeleteBookEvent({
    required this.book,
  });
}

class RemoveBookEvent extends BooksEvent {
  final Book book;
  RemoveBookEvent({
    required this.book,
  });
}

class RefreshBookEvent extends BooksEvent {
  final Book book;
  RefreshBookEvent({
    required this.book,
  });
}

class AddChapterEvent extends BooksEvent {
  final Book book;
  final Chapter chapter;
  AddChapterEvent({
    required this.book,
    required this.chapter,
  });
 

}

class DeleteChapterEvent extends BooksEvent {
  final List<Chapter> chapters;
  DeleteChapterEvent({
    required this.chapters,
  });
}
