import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:movies_app/bloc/main_bloc.dart';
import 'package:movies_app/bloc/main_state.dart';
import 'package:movies_app/constances/theme.dart';
import 'package:movies_app/views/populer_screen.dart';
import 'package:movies_app/views/top_rated_screen.dart';
import 'package:movies_app/views/up_coming.dart';
import 'package:movies_app/views/wish_list.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('movies'),
            bottom: TabBar(
              tabs: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'popular movies',
                      textAlign: TextAlign.center,
                    ),
                    Icon(Icons.movie_creation_outlined),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'top rated',
                      textAlign: TextAlign.center,
                    ),
                    Icon(Icons.whatshot_outlined),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'up coming',
                      textAlign: TextAlign.center,
                    ),
                    Icon(Icons.upcoming),
                  ],
                ),
              ],
              controller: tabController,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    MainCubit.get(context).changeThemeMode();
                  },
                  icon: Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.white,
                  )),
              TextButton(
                  onPressed: () {
                    navigateTo(context, WishListScreen());
                  },
                  child: AutoSizeText(
                    'wish list',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  )),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                        MainCubit.get(context).popularModel != null &&
                        MainCubit.get(context).topRated != null &&
                        MainCubit.get(context).upComing != null,
                    widgetBuilder: (context) => TabBarView(
                          children: [
                            PopularScreen(),
                            TopRatedScreen(),
                            UpComingScreen(),
                          ],
                          controller: tabController,
                        ),
                    fallbackBuilder: (context) => Center(
                            child: CircularProgressIndicator(
                          color: MyColor.mainColor,
                        )));
              } else {
                return buildNoNetwork(context);
              }
            },
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

buildNoNetwork(context) => Container(
      color: MyColor.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
          ),
          AutoSizeText(
            'check your connection!!!',
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 25.0),
          ),
          Image.asset(
            'assets/images/warning.png',
            fit: BoxFit.cover,
          )
        ],
      ),
    );

buildFallBackWidget(context) => Scaffold(
        body: Center(
            child: CircularProgressIndicator(
      color: MyColor.mainColor,
    )));
