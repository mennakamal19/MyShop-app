import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop_app/layout/cubit/cubit.dart';
import 'package:myshop_app/shared/bloc_observer.dart';
import 'package:myshop_app/shared/cubit/cubit.dart';
import 'package:myshop_app/shared/cubit/states.dart';
import 'package:myshop_app/shared/network/local/cache_helper.dart';
import 'package:myshop_app/shared/network/remote/dio_helper.dart';
import 'package:myshop_app/shared/styles/themes.dart';
import 'package:bloc/bloc.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  // token = CacheHelper.getData(key: 'token');
  // print(token);


  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}


class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context )=> AppCubit()..changeAppMode(fromShared: isDark!),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:startWidget,
          );
        },
      ),
    );
  }
}

