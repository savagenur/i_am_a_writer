import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_am_a_writer/draft/detail_page.dart';
import 'package:i_am_a_writer/models/book.dart';
import 'package:i_am_a_writer/pages/home_page.dart';

import '../models/chapter.dart';
import '../draft/chapters_page.dart';
import '../pages/detail_chapter_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case ChaptersPage.id:
        return MaterialPageRoute(builder: (_) => ChaptersPage());case HomePage.id:
        return MaterialPageRoute(builder: (_) => HomePage());
      case DetailPage.id:
        Chapter arguments = routeSettings.arguments as Chapter;
        if (arguments is Chapter) {
          return MaterialPageRoute(
              builder: (_) => DetailPage(
                    chapter: arguments,
                  ));
        }
        return null;

      case DetailChapterPage.id:
        final arguments = routeSettings.arguments as DetailChapterPage;

        return MaterialPageRoute(
            builder: (_) => DetailChapterPage(
                  chapter: arguments.chapter,
                  book: arguments.book,
                ));

      default:
        return null;
    }
  }
}
