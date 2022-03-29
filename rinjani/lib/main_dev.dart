import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rinjani/resources/app_config.dart';
import 'package:rinjani/rinjani_app.dart';
import 'app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DotEnv().load('.env-app');
  final url = DotEnv().env['BASE_URL'];
  final appModule = AppModule(url);
  await appModule.setup();
  final rootApp = appModule.configureBloc(RinjaniApp());

  final app =
  AppConfig(urlEndpoint: url, buildFlavor: "development", child: rootApp);
  runApp(app);
}
