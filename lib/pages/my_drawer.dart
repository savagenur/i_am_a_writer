import 'package:flutter/material.dart';
import 'package:i_am_a_writer/constants/constants.dart';
import 'package:i_am_a_writer/models/book.dart';
import 'package:i_am_a_writer/models/chapter.dart';
import 'package:i_am_a_writer/pages/add_book_screen.dart';
import 'package:i_am_a_writer/pages/detail_chapter_page.dart';
import 'package:i_am_a_writer/services/uniqie_id.dart';
import 'package:i_am_a_writer/widgets/chapters_list.dart';
import 'package:intl/intl.dart';

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
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

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
                      _buildAppBar(booksState, selectedState, context),
                      _buildBooksList(booksState, selectedState),
                      selectedState.selectMode
                          ? Container()
                          : const SizedBox(
                              height: defaultPadding,
                            ),
                      selectedState.selectMode
                          ? buildBottomBar(booksState, selectedState)
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

  Container buildBottomBar(BooksState booksState, SelectedState selectedState) {
    return Container(
      height: defaultPadding * 4,
      decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultPadding),
            topRight: Radius.circular(defaultPadding),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            label: Text("Delete"),
            onPressed: (() {
              // ! Delete all selectedItems
              booksState.allBooks.forEach((book) {
                book.chapters.forEach((chapter) {
                  if (chapter.isSelected!) {
                    _selectedItems.add(chapter);
                  }
                });
              });

              context
                  .read<BooksBloc>()
                  .add(DeleteChapterEvent(chapters: _selectedItems));

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
              onPressed: () {
                //! Uncheck all selectedItems

                booksState.allBooks.forEach((book) {
                  book.chapters.forEach((chapter) {
                    if (chapter.isSelected!) {
                      _selectedItems.add(chapter);
                    }
                  });
                });
                _selectedItems.forEach((selectedChapter) {
                  setState(() {
                    booksState.allBooks.forEach((book) {
                      book.chapters.forEach((chapter) {
                        if (selectedChapter == chapter) {
                          int index = book.chapters.indexOf(chapter);
                          book.chapters
                            ..remove(chapter)
                            ..insert(
                                index, chapter.copyWith(isSelected: false));
                        }
                      });
                    });
                  });
                });

                setState(() {
                  selectedState.selectMode = false;
                });
              },
              child: Text("Cancel")),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BooksState booksState, SelectedState selectedState,
      BuildContext context) {
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
        IconButton(
            onPressed: () {
              selectedState.isZoomIn = !selectedState.isZoomIn;
              booksState.allBooks.forEach((book) {
                int index = booksState.allBooks.indexOf(book);
                booksState.allBooks.remove(book);
                booksState.allBooks.insert(
                    index, book.copyWith(isExpanded: selectedState.isZoomIn));
              });
              setState(() {});
            },
            icon: selectedState.isZoomIn
                ? Icon(Icons.zoom_out)
                : Icon(Icons.zoom_in)),
        IconButton(
            onPressed: () {
              AddBook()
                  .addBook(context: context, titleController: titleController, refreshScreen: refreshScreen);
            },
            icon: Icon(Icons.create_new_folder))
      ],
    );
  }
void refreshScreen( ){
  setState(() {
    
  });
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
                return ExpansionPanelList(
                  expandedHeaderPadding: EdgeInsets.only(left: 10, top: 10),
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() {
                      booksState.allBooks[panelIndex].isExpanded =
                          !booksState.allBooks[panelIndex].isExpanded!;
                    });
                  },
                  animationDuration: Duration(milliseconds: 800),
                  children: booksState.allBooks.map((book) {
                    List<Chapter> chapters = book.chapters;

                    return ExpansionPanel(
                        backgroundColor: book.isExpanded!
                            ? Colors.grey[900]
                            : Colors.grey[850],
                        canTapOnHeader: true,
                        headerBuilder: (context, isExpanded) {
                          return GestureDetector(
                            onLongPress: () {
                              _showDialog(context, book.title, book);
                            },
                            child: ListTile(
                              tileColor: Colors.transparent,
                              minLeadingWidth: 10,
                              isThreeLine: true,
                              subtitle: Row(
                                children: [
                                  Chip(
                                      label: Text(
                                    'Chapters: ${book.chapters.length}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ))
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
                                      dateTime: DateFormat('d/M/y')
                                          .add_Hm()
                                          .format(DateTime.now()),
                                      title: '',
                                      id: getUid(),
                                      content: '',
                                    );
                                    context.read<BooksBloc>().add(
                                        AddChapterEvent(
                                            book: book, chapter: chapter));
                                    book.isExpanded = true;
                                    setState(() {});
                                    // Navigator.of(context).pushNamed(
                                    //     DetailChapterPage.id,
                                    //     arguments: DetailChapterPage(
                                    //         chapter: chapter, book: book));
                                  },
                                  icon: CircleAvatar(
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
                        isExpanded: book.isExpanded!);
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
                            refreshScreen:refreshScreen,
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
