import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:i_am_a_writer/constants/constants.dart';
import 'package:i_am_a_writer/pages/detail_chapter_page.dart';

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
                    radius: 15,
                    child: Text((index + 1).toString()),
                  ),
                  minLeadingWidth: defaultPadding,
                  onTap: () {
                    Navigator.of(context).pushNamed(DetailChapterPage.id,
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
                    });
                  },
                  title: Text(
                    chapter.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  subtitle: chapter.content.isEmpty
                      ? Text(
                          '<--->',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontStyle: FontStyle.italic),
                        )
                      : Text(
                          chapter.content,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontStyle: FontStyle.italic),
                        ),
                  trailing: selectedState.selectMode
                      ? Checkbox(
                          value: chapter.isDone,
                          onChanged: (value) {
                            chapter.isDone = value;
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
