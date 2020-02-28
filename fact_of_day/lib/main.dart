import 'package:admob_flutter/admob_flutter.dart';
import 'package:fact_of_day/data/device_local_repository.dart';
import 'package:fact_of_day/data/fact_repository.dart';
import 'package:fact_of_day/data/local/tables.dart';
import 'package:fact_of_day/data/open_url_repository.dart';
import 'package:fact_of_day/domain/get_credits_usecase.dart';
import 'package:fact_of_day/domain/get_language_code_usecase.dart';
import 'package:fact_of_day/domain/get_random_fact_usecase.dart';
import 'package:fact_of_day/domain/url_launcher_usecase.dart';
import 'package:fact_of_day/generated/i18n.dart';
import 'package:fact_of_day/tabs/favorite_tab.dart';
import 'package:fact_of_day/tabs/start_tab.dart';
import 'package:fact_of_day/ui/bottom_nav_controller.dart';
import 'package:fact_of_day/ui/viewmodel.dart';
import 'package:fact_of_day/utils/banner_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final injector = ModuleContainer().initialise(Injector.getInjector());

  final ViewModel viewModel = injector.get<ViewModel>();

  Admob.initialize(ANDROID_AD_UNIT_ID);
  runApp(App(viewModel));
}

class ModuleContainer {
  Injector initialise(Injector injector) {
    injector.map<FactRepository>((i) => FactRepository(), isSingleton: true);
    injector.map<DeviceLocalRepository>((i) => DeviceLocalRepository(),
        isSingleton: true);
    injector.map<GetLanguageCodeUseCase>(
        (i) => GetLanguageCodeUseCase(i.get<DeviceLocalRepository>()));

    injector.map<GetRandomFactUseCase>((i) => GetRandomFactUseCase(
        i.get<GetLanguageCodeUseCase>(), i.get<FactRepository>()));

    injector.map<GetCreditsUseCase>((i) => GetCreditsUseCase());

    injector.map<OpenUrlRepository>((i) => OpenUrlRepository());
    injector.map<UrlLauncherUseCase>(
        (i) => UrlLauncherUseCase(i.get<OpenUrlRepository>()));

    injector.map<ViewModel>((i) => ViewModel(
        i.get<GetLanguageCodeUseCase>(),
        i.get<GetRandomFactUseCase>(),
        i.get<GetCreditsUseCase>(),
        i.get<UrlLauncherUseCase>()));

    return injector;
  }
}

class App extends StatelessWidget {
  final ViewModel viewModel;

  const App(
    this.viewModel, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MultiProvider(providers: [
        Provider(create: (_) => Database().favoriteDao),
        Provider(create: (_) => viewModel)
      ], child: BottomNavigationBarController()),
      locale: Locale("en", ""),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback:
          S.delegate.resolution(fallback: new Locale("en", "")),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [StartTab(), FavoriteTab(), FavoriteTab()];

    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).primaryTextTheme.title.color,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            title: Text('Facts'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    print(index);
    setState(() {
      _currentIndex = index;
    });
  }
}
