import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/utils/dependency_injection.dart' as di;
import 'package:flutter_template/viewModel/home_test_view_model.dart';
import 'package:flutter_template/viewModel/product_view_model.dart';
import 'package:flutter_template/views/views.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  await di.init();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      child: DefaultSizeInit(builder: () => const MyApp()),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
      ],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductViewModel>.value(value: GetIt.I.get()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: Themes.light,
          darkTheme: Themes.dark,
          themeMode: ThemeMode.system,
          initialRoute: SplashScreen.id,
          routes: {
            SplashScreen.id: (context) => const SplashScreen(),
            HomeView.id: (context) => const HomeView(),
            FavoritesView.id: (context) => const FavoritesView(),
          },
        ),
      ),
    );
  }
}
