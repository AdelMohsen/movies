import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/main_bloc.dart';
import 'package:movies_app/bloc/main_state.dart';
import 'package:movies_app/constances/theme.dart';
import 'package:movies_app/network/dio_helper.dart';
import 'package:movies_app/network/ob_server.dart';
import 'package:movies_app/views/main_view.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..createDataBase()
        ..getPopularData()
        ..getTopRatedData()
        ..getUpComingData(),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: MainCubit.get(context).mode
                ? lightTheme(context)
                : darkTheme(context),
            home: MainScreen(),
          );
        },
      ),
    );
  }
}
