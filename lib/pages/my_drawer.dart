import 'package:flutter/material.dart';
import 'package:i_am_a_writer/constants/constants.dart';
import 'package:i_am_a_writer/models/book.dart';
import 'package:i_am_a_writer/models/chapter.dart';
import 'package:i_am_a_writer/pages/add_book_screen.dart';
import 'package:i_am_a_writer/pages/detail_chapter_page.dart';
import 'package:i_am_a_writer/services/uniqie_id.dart';
import 'package:i_am_a_writer/widgets/chapters_list.dart';

import '../blocs/bloc_exports.dart';
import '../draft/detail_page.dart';
import 'book_chapter_list.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int _chapters = 0;
  List<Chapter> _selectedItems = [];
  TextEditingController titleController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .9,
      child: BlocBuilder<SelectedBloc, SelectedState>(
        builder: (context, selectedState) {
          return BlocBuilder<BooksBloc, BooksState>(
            builder: (context, booksState) {
              return Stack(
                children: [
                  Column(
                    children: [
                      _buildAppBar(booksState, context),
                      _buildBooksList(booksState, selectedState),
                      selectedState.selectMode
                          ? Container()
                          : const SizedBox(
                              height: defaultPadding,
                            ),
                      selectedState.selectMode
                          ? Container(
                              height: defaultPadding * 4,
                              decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(defaultPadding),
                                    topRight: Radius.circular(defaultPadding),
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    label: Text("Delete"),
                                    onPressed: (() {
                                      booksState.allBooks.forEach((book) {
                                        book.chapters.forEach((chapter) {
                                          if (chapter.isDone!) {
                                            _selectedItems.add(chapter);
                                          }
                                        });
                                      });
                                      _selectedItems.forEach((chapter) {
                                        setState(() {
                                          booksState.allBooks.forEach((book) {
                                            book.chapters.remove(chapter);
                                          });
                                        });
                                      });

                                      setState(() {
                                        selectedState.selectMode = false;
                                      });
                                    }),
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: (() {
                                        selectedState.selectMode =
                                            !selectedState.selectMode;
                                        setState(() {});
                                      }),
                                      child: Text("Cancel")),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BooksState booksState, BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Center(
          child: Chip(
              label: Text(
        "Books: ${booksState.allBooks.length}",
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(fontWeight: FontWeight.bold),
      ))),
      leadingWidth: MediaQuery.of(context).size.width * .4,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () {
              AddBook()
                  .addBook(context: context, titleController: titleController);
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            label: Text("Add Book", style: TextStyle(color: Colors.black)),
            style: ElevatedButton.styleFrom(
                primary: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultPadding * 2),
                )),
          ),
        )
      ],
    );
  }

  Expanded _buildBooksList(
    BooksState booksState,
    SelectedState selectedState,
  ) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: defaultPadding,
            ),
            BlocBuilder<ChaptersBloc, ChaptersState>(
              builder: (context, state) {
                return ExpansionPanelList.radio(
                  elevation: 0,
                  children: booksState.allBooks.map((book) {
                    List<Chapter> chapters = book.chapters;
                    // booksState.allBooks.forEach((book) {
                    //   book.chapters.forEach((chapter) {
                    //     if (chapter.isDone!) {
                    //       _selectedItems.add(chapter);
                    //     }
                    //   });
                    // });
                    return ExpansionPanelRadio(
                        canTapOnHeader: true,
                        headerBuilder: (context, isExpanded) {
                          return GestureDetector(
                            onLongPress: () {
                              _showDialog(context, book.title, book);
                              // _bottomSheetMenu(context);
                            },
                            child: ListTile(
                              minLeadingWidth: 10,
                              selectedTileColor:
                                  isExpanded ? Colors.amber : Colors.black,
                              selectedColor:
                                  isExpanded ? Colors.amber : Colors.black,
                              contentPadding: EdgeInsets.only(
                                  left: defaultPadding,
                                  top: defaultPadding / 2,
                                  bottom: defaultPadding / 2),
                              isThreeLine: true,
                              subtitle: Row(
                                children: [
                                  Chip(
                                      label: Text(
                                          'Chapters: ${book.chapters.length}'))
                                ],
                              ),
                              title: Text(
                                book.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    var chapter = Chapter(
                                      title: '',
                                      id: getUid(),
                                      content: '',
                                    );
                                    context.read<BooksBloc>().add(
                                        AddBookChapterEvent(
                                            book: book, chapter: chapter));
                                    setState(() {});
                                    // Navigator.of(context).pushNamed(
                                    //     DetailChapterPage.id,
                                    //     arguments: DetailChapterPage(
                                    //         chapter: chapter, book: book));
                                  },
                                  icon: CircleAvatar(
                                      radius: defaultPadding,
                                      backgroundColor: buttonColor,
                                      child: Icon(Icons.add))),
                            ),
                          );
                        },
                        body: BookChapterList(
                          refresh: refresh,
                          chaptersList: chapters,
                          book: book,
                        ),
                        value: book.id);
                  }).toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void refresh(
    List<Chapter> newChapters,
  ) {
    setState(() {
      _chapters = newChapters.length;
    });
  }

  _showDialog(BuildContext context, String title, Book book) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              alignment: Alignment.center,
              title: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * .2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);

                          AddBook().addBook(
                              context: context,
                              titleController:
                                  TextEditingController(text: book.title),
                              book: book,
                              isAddBook: false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Rename",
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _deleteDialog(context, book);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Delete",
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ));
  }

  void _deleteDialog(BuildContext context, Book book) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Are you sure you want to delete this book?"),
              content: Text(
                "${book.title}}",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      context
                          .read<BooksBloc>()
                          .add(DeleteBookEvent(book: book));
                      Navigator.pop(context);
                    },
                    child: Text("Delete")),
              ],
            ));
  }
}
