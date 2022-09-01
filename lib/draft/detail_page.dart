import 'package:flutter/material.dart';
import 'package:i_am_a_writer/blocs/bloc_exports.dart';
import 'package:i_am_a_writer/constants/constants.dart';

import '../pages/my_drawer.dart';
import '../models/chapter.dart';

class DetailPage extends StatefulWidget {
  static const String id = "/detail";

  final Chapter chapter;
  DetailPage({Key? key, required this.chapter}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late String title;
  late String content;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.chapter.title);
    contentController = TextEditingController(text: widget.chapter.content);
    content = widget.chapter.content;
    contentController.addListener(() {
      content = contentController.text;
      context
          .read<ChaptersBloc>()
          .add(ContentCharachterCountEvent(content: content.length));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("I'm a Writer"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<ChaptersBloc>(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: defaultPadding / 4, horizontal: defaultPadding),
          child: Column(
            children: [
              BlocBuilder<ChaptersBloc, ChaptersState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Chip(label: Text(state.contentChar.toString()))],
                  );
                },
              ),
              TextField(
                controller: titleController,
                textAlign: TextAlign.center,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _doneButton,
        child: Icon(Icons.done),
      ),
    );
  }

  void _doneButton() {
    if (titleController.text == '' && contentController.text == '') {
      context
          .read<ChaptersBloc>()
          .add(DeleteChapterEvent(chapter: widget.chapter));
      Navigator.pop(context);
    } else if (titleController.text == '') {
      titleController.text = 'Untitled*';
      context.read<ChaptersBloc>().add(UpgradeChapterEvent(
          chapter: widget.chapter,
          newChapter: widget.chapter.copyWith(
            title: titleController.text,
            content: contentController.text,
          )));
      Navigator.pop(context);
    } else {
      context.read<ChaptersBloc>().add(UpgradeChapterEvent(
          chapter: widget.chapter,
          newChapter: widget.chapter.copyWith(
            title: titleController.text,
            content: contentController.text,
          )));
      Navigator.pop(context);
    }
  }
}
