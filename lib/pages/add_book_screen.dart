import 'package:flutter/material.dart';
import 'package:i_am_a_writer/models/book.dart';
import 'package:i_am_a_writer/models/chapter.dart';
import 'package:i_am_a_writer/pages/detail_chapter_page.dart';
import 'package:i_am_a_writer/services/uniqie_id.dart';
import 'package:intl/intl.dart';

import '../blocs/bloc_exports.dart';
import '../constants/constants.dart';

class AddBook {
  void addBook({
    required BuildContext context,
    required TextEditingController titleController,
    Book? book,
    bool isAddBook = true,
    required VoidCallback refreshScreen,
  }) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultPadding)),
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: Column(
                  children: [
                    Text(
                      isAddBook ? "Add Book" : "Rename Book",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: defaultPadding / 2,
                    ),
                    TextField(
                      controller: titleController,
                      autofocus: true,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        label: Text("Title"),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel')),
                        isAddBook
                            ? ElevatedButton(
                                onPressed: () {
                                  var title = titleController.text;
                                  var chapter = Chapter(
                                      dateTime: DateFormat.yMd()
                                          .add_Hm()
                                          .format(DateTime.now()),
                                      title: '<Untitled>',
                                      id: getUid(),
                                      content: '');
                                  var book = Book(
                                      chapters: [chapter],
                                      isExpanded: false,
                                      title: title == ''
                                          ? "<No Name>"
                                          : titleController.text,
                                      id: getUid());

                                   if (state.allBooks.isNotEmpty) {
                                    state.allBooks.last.isExpanded = false;
                                  }
                                  context
                                      .read<BooksBloc>()
                                      .add(AddBookEvent(book: book));
                                  Navigator.pop(context);
                                  // Navigator.of(context).pushNamed(
                                  //     DetailChapterPage.id,
                                  //     arguments: DetailChapterPage(
                                  //         chapter: chapter, book: book));
                                },
                                child: Text('Add'),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  var title = titleController.text;
                                  if (state.allBooks.isNotEmpty) {
                                    state.allBooks.last.isExpanded = false;
                                  }


                                  context.read<BooksBloc>().add(RenameBookEvent(
                                      book: book!,
                                      renamedBook:
                                          book.copyWith(title: title)));
                                  Navigator.pop(context);
                                },
                                child: Text(isAddBook ? 'Add' : 'Rename'),
                              )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    isAddBook ? titleController.text = '' : null;
  }
}
