import 'package:flutter/material.dart';
import 'package:i_am_a_writer/draft/detail_page.dart';
import 'package:i_am_a_writer/services/uniqie_id.dart';

import '../blocs/bloc_exports.dart';
import '../models/chapter.dart';

class AddChapterScreen extends StatefulWidget {
  AddChapterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddChapterScreen> createState() => _AddChapterScreenState();
}

class _AddChapterScreenState extends State<AddChapterScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Add Chapter",
              style: Theme.of(context).textTheme.headline5,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
              ),
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
              autofocus: true,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      var chapter = Chapter(
                        dateTime: '',
                        title: titleController.text,
                        content: contentController.text,
                        id: getUid(),
                      );
                      context.read<ChaptersBloc>().add(AddChapterEvent(
                            chapter: chapter,
                          ));
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(
                        DetailPage.id,
                        arguments: chapter,
                      );
                    },
                    child: Text("Add"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
