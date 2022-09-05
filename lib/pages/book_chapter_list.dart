import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:i_am_a_writer/constants/constants.dart';
import 'package:i_am_a_writer/pages/detail_chapter_page.dart';
import 'package:i_am_a_writer/pages/home_page.dart';

import '../blocs/bloc_exports.dart';
import '../draft/detail_page.dart';
import '../models/book.dart';
import '../models/chapter.dart';

class BookChapterList extends StatefulWidget {
  final List<Chapter> chaptersList;
  final Book book;
  final void Function(List<Chapter>) refresh;
  const BookChapterList({
    Key? key,
    required this.chaptersList,
    required this.book,
    required this.refresh,
  }) : super(key: key);

  @override
  State<BookChapterList> createState() => _BookChapterListState();
}

class _BookChapterListState extends State<BookChapterList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedBloc, SelectedState>(
      builder: (context, selectedState) {
        return BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.chaptersList.length,
              itemBuilder: (BuildContext context, int index) {
                var chapter = widget.chaptersList[index];
                if (chapter.title == '') {
                  chapter.title = '<Untitled>';
                }

                return ListTile(
                  contentPadding: EdgeInsets.all(defaultPadding * .5),
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[850],
                    radius: 10,
                    child: Text(
                      (index + 1).toString(),
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  minLeadingWidth: defaultPadding,
                  onTap: () {
                    selectedState.selectMode
                        ? setState(() {
                            chapter.isSelected = !chapter.isSelected!;
                          })
                        : Navigator.of(context).pushNamed(DetailChapterPage.id,
                            arguments: DetailChapterPage(
                              chapter: chapter,
                              book: widget.book,
                            ));
                  },
                  onLongPress: () {
                    // widget.chaptersList.remove(chapter);
                    // _bottomSheetMenu(context);
                    widget.refresh(widget.chaptersList);
                    setState(() {
                      selectedState.selectMode = !selectedState.selectMode;
                      chapter.isSelected = !chapter.isSelected!;
                    });
                  },
                  title: Text(
                    chapter.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  subtitle: chapter.content.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '<--->',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                      color: Colors.grey[600]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Updated at ${chapter.dateTime}, ${chapter.wordsCount} words",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              chapter.content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                      color: Colors.grey[600]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Updated at ${chapter.dateTime}, ${chapter.wordsCount} words",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                  trailing: selectedState.selectMode
                      ? Checkbox(
                          value: chapter.isSelected,
                          onChanged: (value) {
                            chapter.isSelected = value;
                            setState(() {});
                          },
                        )
                      : null,
                );
              },
            );
          },
        );
      },
    );
  }

  // void _bottomSheetMenu(context) {
  //   showModalBottomSheet(

  //     backgroundColor: Color.fromARGB(255, 76, 76, 78),
  //       context: context,
  //       builder: (context) => Container(
  //         height: MediaQuery.of(context).size.height*.1,
  //         child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(Icons.delete,color: Colors.red,),
  //                     Text('Delete'),
  //                   ],
  //                 ),
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(Icons.cancel_outlined),
  //                     Text('Back'),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //       ));
  // }
}
