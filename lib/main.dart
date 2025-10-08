import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/global/debug.dart';
import 'package:natie_portfolio/store/global/dimen_store.dart';
import 'package:provider/provider.dart';

import 'data/firebase/firestore.dart';
import 'firebase_options.dart';
import 'global/router.dart' as rt;
import 'global/strings.dart';
import 'global/styles.dart';
import 'l10n/app_localizations.dart';
import 'store/data/bio_store.dart';
import 'store/data/project_store.dart';
import 'store/global/language_store.dart';
import 'store/global/theme_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Debug.log('App started at ${DateTime.now()}');
  runApp(
    MultiProvider(
      providers: [
        Provider<BioStore>(create: (_) => BioStore()),
        Provider<DimenStore>(create: (_) => DimenStore()),
        Provider<LanguageStore>(create: (_) => LanguageStore()),
        Provider<ProjectStore>(create: (_) => ProjectStore()),
        Provider<ThemeStore>(create: (_) => ThemeStore()),
      ],
      child: const NatiePortfolio(),
    ),
  );
}

class NatiePortfolio extends StatefulWidget {
  const NatiePortfolio({super.key});

  @override
  State<NatiePortfolio> createState() => _NatiePortfolioState();
}

class _NatiePortfolioState extends State<NatiePortfolio> {
  bool _bootstrapCompleted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_bootstrapCompleted) return;
    context.read<ThemeStore>().getActiveTheme();
    context.read<LanguageStore>().getActiveLanguage();
    unawaited(Firestore.bootstrap(context));
    _bootstrapCompleted = true;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Observer(
          builder: (_) {
            rt.Router.init(context);
            context.read<DimenStore>().updateScreenSize(Size(constraints.maxWidth, constraints.maxHeight));
            return MaterialApp(
              title: Strings.of(context).title,
              debugShowCheckedModeBanner: true,
              // Theme
              themeMode: context.read<ThemeStore>().activeTheme,
              theme: Themes.light,
              darkTheme: Themes.dark,
              // Locale
              locale: Strings.of(context).locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              // Pages
              initialRoute: Debug.isProduction ? rt.Routes.home : rt.Routes.debug,
              onGenerateRoute: rt.Router.generateRoute,
            );
          },
        );
      },
    );
  }
}
