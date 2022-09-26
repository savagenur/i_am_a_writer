import 'package:flutter/material.dart';
import 'package:i_am_a_writer/constants/constants.dart';
import 'package:i_am_a_writer/models/chapter.dart';
import 'package:i_am_a_writer/draft/detail_page.dart';
import 'package:i_am_a_writer/services/uniqie_id.dart';

import '../blocs/bloc_exports.dart';
import '../pages/my_drawer.dart';
import '../widgets/chapters_list.dart';
import 'add_chapter_screen.dart';

class ChaptersPage extends StatelessWidget {
  static const String id = '/chapters';
  ChaptersPage({Key? key}) : super(key: key);

  void _addChapter(BuildContext ctx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          defaultPadding,
        )),
        isScrollControlled: true,
        context: ctx,
        builder: (ctx) => SingleChildScrollView(
              child: AddChapterScreen(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChaptersBloc, ChaptersState>(
      builder: (context, state) {
        List<Chapter> chaptersList = state.allChapters;
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text("I'm a Writer!"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                    label: Text(
                        'Chapters: ' + chaptersList.length.toString())),
              ),
              ChaptersList(chaptersList: chaptersList),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              var chapter = Chapter(dateTime: '', title: '', id: getUid(), content: '');
              context.read<ChaptersBloc>().add(AddChapteREvent(
                    chapter: chapter,
                  ));
              Navigator.of(context)
                  .pushNamed(DetailPage.id, arguments: chapter);
              // _addChapter(context);
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
