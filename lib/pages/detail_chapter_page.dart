import 'package:flutter/material.dart';
import 'package:i_am_a_writer/blocs/bloc_exports.dart';
import 'package:i_am_a_writer/constants/constants.dart';
import 'package:i_am_a_writer/main.dart';
import 'package:i_am_a_writer/models/book.dart';
import 'package:i_am_a_writer/pages/home_page.dart';

import '../pages/my_drawer.dart';
import '../models/chapter.dart';

class DetailChapterPage extends StatefulWidget {
  static const String id = "/detail-chapter";

  final Chapter chapter;
  final Book book;
  DetailChapterPage({Key? key, required this.chapter, required this.book})
      : super(key: key);

  @override
  State<DetailChapterPage> createState() => _DetailChapterPageState();
}

class _DetailChapterPageState extends State<DetailChapterPage> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late String title;
  late String content;
  late List<String> wordsCount;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.chapter.title);
    contentController = TextEditingController(text: widget.chapter.content);
    content = widget.chapter.content;
    wordsCount = contentController.text.split(' ');

    contentController.addListener(() {
      setState(() {
        content = contentController.text;
        wordsCount = content.split(' ');
      });

      title = titleController.text;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 4, horizontal: defaultPadding),
        child: Column(
          children: [
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Chip(label: Text('Book: ' + widget.book.title)),
                    ),
                  ],
                ),
                Positioned(
                    right: 0,
                    child: Chip(label: Text((wordsCount.length).toString())))
              ],
            ),
            TextField(
              controller: titleController,
              textAlign: TextAlign.center,
              onTap: () => titleController.text == '<Untitled>'
                  ? titleController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: titleController.value.text.length,
                    )
                  : null,
              style: Theme.of(context).textTheme.headline6,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey)),
              minLines: 1,
              maxLines: 5,
            ),
            Expanded(
              child: TextField(
                  controller: contentController,
                  autofocus: true,
                  maxLines: null,
                  minLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  expands: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Start writing some content...")),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _doneButton,
        child: Icon(Icons.done),
      ),
    );
  }

  void _doneButton() {
    var chapter = widget.chapter;
    var book = widget.book;
    int index = book.chapters.indexOf(chapter);

    if (titleController.text == '' && contentController.text == '') {
      book.chapters.remove(chapter);
      context
          .read<BooksBloc>()
          .add(RefreshBookEvent( book: book));
      Navigator.pop(context);
    } else if (titleController.text == '') {
      title = '';
      book.chapters.remove(chapter);
      book.chapters
          .insert(index, chapter.copyWith(title: title, content: content));
      context
          .read<BooksBloc>()
          .add(RefreshBookEvent( book: book));

      Navigator.pop(context);
    } else {
      book.chapters.remove(chapter);
      book.chapters.insert(index,
          chapter.copyWith(title: titleController.text, content: content));
      context
          .read<BooksBloc>()
          .add(RefreshBookEvent( book: book));
      Navigator.pop(context);
    }
  }
}
