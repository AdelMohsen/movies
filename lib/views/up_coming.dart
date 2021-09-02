import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/bloc/main_bloc.dart';
import 'package:movies_app/bloc/main_state.dart';
import 'package:movies_app/constances/const_string.dart';
import 'package:movies_app/constances/reuse_widgets.dart';
import 'package:movies_app/models/UpComing.dart';
import 'package:movies_app/views/previews_screen/up_coming.dart';

class UpComingScreen extends StatefulWidget {
  const UpComingScreen({Key? key}) : super(key: key);

  @override
  _UpComingScreenState createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        var upComing = MainCubit.get(context).upComing;
        return buildUpComingItem(context, cubit, upComing!);
      },
    );
  }
}

buildUpComingItem(context, MainCubit cubit, UpComing? upComing) =>
    StaggeredGridView.countBuilder(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        mainAxisSpacing: 8,
        crossAxisSpacing: 2,
        itemCount: upComing!.result.length,
        crossAxisCount: 2,
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                navigateTo(context, UpComingPreviewScreen(upComing, index));
              },
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInImage.assetNetwork(
                        placeholder: 'assets/images/loading.gif',
                        image:
                            '$imageKey${upComing.result[index].posterImage}'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        '${upComing.result[index].title}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AutoSizeText(
                        '${upComing.result[index].releaseDate}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20, color: Colors.blueAccent),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          AutoSizeText(
                            '${upComing.result[index].voteAverage}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Icon(Icons.star_rate_rounded),
                          Spacer(),
                          Spacer(),
                          cubit.changeFaVIcon
                              ? IconButton(
                                  onPressed: () {
                                    cubit.changeIcon();
                                    cubit.insertInWishListTable(
                                        index: index.toString(),
                                        name: upComing.result[index].title,
                                        releaseDate:
                                            upComing.result[index].releaseDate,
                                        voteRate:
                                            upComing.result[index].voteAverage,
                                        overView:
                                            upComing.result[index].overView);
                                  },
                                  icon: Icon(
                                    Icons.favorite_border_sharp,
                                    size: 30,
                                    color: HexColor('#ac1457'),
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    cubit.changeIcon();
                                    cubit.deleteFromWishListTable(
                                        title:
                                        upComing.result[index].title);
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: HexColor('#ac1457'),
                                  )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        staggeredTileBuilder: (index) => StaggeredTile.fit(1));
