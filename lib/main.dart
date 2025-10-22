import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:natie_portfolio/data/services/firestore.dart';
import 'package:natie_portfolio/global/debug.dart';
import 'package:natie_portfolio/global/vars.dart';
import 'package:natie_portfolio/store/global/dimen_store.dart';
import 'package:natie_portfolio/widget/common/web_item.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

import 'firebase_options.dart';
import 'global/routes.dart';
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
            context.read<DimenStore>().updateScreenSize(Size(constraints.maxWidth, constraints.maxHeight));
            return MaterialApp.router(
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
              routerDelegate: RoutemasterDelegate(
                navigatorKey: Vars.navigatorKey,
                routesBuilder: (_) => Routes.routeMap,
                observers: [PortRouteObserver()],
              ),
              routeInformationParser: RoutemasterParser(),
              // Common widgets
              builder: (_, child) => Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (_) => Scaffold(key: Vars.globalScaffoldKey, drawer: const WebDrawer(), body: child),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
