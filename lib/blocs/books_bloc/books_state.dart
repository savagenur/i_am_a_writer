part of 'books_bloc.dart';

class BooksState extends Equatable {
  final List<Book> allBooks;
  final Chapter? chapter;
  const BooksState({this.allBooks = const <Book>[],this.chapter});

  @override
  List<Object> get props => [allBooks];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'allBooks': allBooks.map((x) => x.toMap()).toList()});

    return result;
  }

  factory BooksState.fromMap(Map<String, dynamic> map) {
    return BooksState(
      allBooks: List<Book>.from(map['allBooks']?.map((x) => Book.fromMap(x))),
    );
  }
}
