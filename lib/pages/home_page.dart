import 'package:flutter/material.dart';
import 'package:i_am_a_writer/constants/constants.dart';
import 'package:i_am_a_writer/main.dart';
import 'package:i_am_a_writer/pages/book_chapter_list.dart';
import 'package:i_am_a_writer/pages/detail_chapter_page.dart';
import 'package:i_am_a_writer/pages/my_drawer.dart';

import '../blocs/bloc_exports.dart';
import '../models/chapter.dart';
import '../services/uniqie_id.dart';
import 'add_book_screen.dart';

class HomePage extends StatelessWidget {
  static const id = '/';
  HomePage({Key? key}) : super(key: key);

 
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(MyApp.title),
        actions: [],
      ),
      body: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, booksState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/journal-book.png",
                  width: 200,
                ),
                SizedBox(height: defaultPadding/2,),
                Text(
                  "Let's write something!)",
                  style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _key.currentState!.openDrawer(),
        child: Icon(Icons.add),
      ),
    );
  }
}
