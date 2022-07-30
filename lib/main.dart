import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'data/firebase/firestore.dart';
import 'firebase_options.dart';
import 'global/router.dart' as rt;
import 'global/strings.dart';
import 'global/styles.dart';
import 'global/vars.dart';
import 'store/data/bio_store.dart';
import 'store/data/project_store.dart';
import 'store/global/language_store.dart';
import 'store/global/theme_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: kReleaseMode ? "natie-portfolio" : null,
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      Provider<ThemeStore>(create: (_) => ThemeStore()),
      Provider<LanguageStore>(create: (_) => LanguageStore()),
      Provider<ProjectStore>(create: (_) => ProjectStore()),
      Provider<BioStore>(create: (_) => BioStore()),
    ],
    child: const NatiePortfolio(),
  ));
}

class NatiePortfolio extends StatelessWidget {
  const NatiePortfolio({Key? key}) : super(key: key);

  static init(BuildContext context) {
    Firestore.init(context);
    Strings.init(context);
    Styles.init(context);
    Themes.init(context);
    Vars.init(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        rt.Router.init(context);
        context.read<ThemeStore>().getActiveTheme();
        context.read<LanguageStore>().getActiveLanguage();
        return MaterialApp(
          title: Strings.title,
          debugShowCheckedModeBanner: false,
          // Theme
          themeMode: context.read<ThemeStore>().activeTheme,
          theme: Themes.light,
          darkTheme: Themes.dark,
          // Locale
          locale: Strings.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // Pages
          initialRoute: rt.Routes.home,
          onGenerateRoute: rt.Router.generateRoute,
        );
      },
    );
  }
}