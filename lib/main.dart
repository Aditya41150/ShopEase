import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';
import './widgets/custom_error_widget.dart';
import './core/utils/navigator_service.dart';
import './core/utils/pref_utils.dart';
import './routes/app_routes.dart';
import './theme/app_theme.dart';
import 'core/app_export.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomErrorWidget(
      errorDetails: details,
    );
  };
  if (!kIsWeb) {
    await Future.wait([
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    ]);
  }
  PrefUtils().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Shop Ease',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
        navigatorKey: NavigatorService.navigatorKey,
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.initial,
      );
    });
  }
}