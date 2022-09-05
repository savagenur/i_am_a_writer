import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_am_a_writer/constants/constants.dart';
import 'package:i_am_a_writer/models/book.dart';
import 'package:i_am_a_writer/draft/chapters_page.dart';
import 'package:i_am_a_writer/routes/app_router.dart';
import 'package:i_am_a_writer/services/uniqie_id.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
    )),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  static const String title = "I'm a Writer!";
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChaptersBloc()),
        BlocProvider(create: (context) => BooksBloc()),
        BlocProvider(create: (context) => SelectedBloc()),
      ],
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute,
        theme: ThemeData(
          
          appBarTheme: AppBarTheme(backgroundColor: primaryColor),
          primaryColor: primaryColor,
          primarySwatch: Colors.grey,
          primaryColorDark: primaryColor,
            textTheme: GoogleFonts.ubuntuTextTheme(ThemeData.dark().textTheme),
            brightness: Brightness.dark,
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(backgroundColor: buttonColor),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: buttonColor,
                onPrimary: Colors.black,
              ),
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(primary: buttonColor)),
            ),
        initialRoute: '/',
      ),
    );
  }
}
