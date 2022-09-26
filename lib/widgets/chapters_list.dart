import 'package:flutter/material.dart';
import 'package:i_am_a_writer/draft/detail_page.dart';
import '../blocs/bloc_exports.dart';
import '../models/chapter.dart';

class ChaptersList extends StatelessWidget {
  const ChaptersList({
    Key? key,
    required this.chaptersList,
  }) : super(key: key);

  final List<Chapter> chaptersList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: chaptersList.length,
      itemBuilder: (BuildContext context, int index) {
        var chapter = chaptersList[index];
        if (chapter.title == '') {
          chapter.title = 'Untitled*';
        }
        return ListTile(
          leading: CircleAvatar(
            child: Text((index + 1).toString()),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              DetailPage.id,
              arguments: chapter,
            );
          },
          onLongPress: () =>
              context.read<ChaptersBloc>().add(DeleteChapteREvent(
                    chapter: chapter,
                  )),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                chapter.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              chapter.content.isEmpty
                  ? Text(
                      '<Untitled>',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontStyle: FontStyle.italic),
                    )
                  : Text(
                      chapter.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
            ],
          ),
          trailing: Checkbox(
            value: chapter.isSelected,
            onChanged: (value) {
              context.read<ChaptersBloc>().add(
                    UpdateChapterEvent(chapter: chapter),
                  );
            },
          ),
        );
      },
    );
  }
}
