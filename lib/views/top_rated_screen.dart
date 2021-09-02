import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/bloc/main_bloc.dart';
import 'package:movies_app/bloc/main_state.dart';
import 'package:movies_app/constances/const_string.dart';
import 'package:movies_app/constances/reuse_widgets.dart';
import 'package:movies_app/models/top_rated.dart';
import 'package:movies_app/views/previews_screen/top_rated.dart';

class TopRatedScreen extends StatefulWidget {
  const TopRatedScreen({Key? key}) : super(key: key);

  @override
  _TopRatedScreenState createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        var topRated = MainCubit.get(context).topRated;
        return buildTopRatedItem(context, cubit, topRated!);
      },
    );
  }
}

buildTopRatedItem(context, MainCubit cubit, TopRated topRated) =>
    StaggeredGridView.countBuilder(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        mainAxisSpacing: 8,
        crossAxisSpacing: 2,
        itemCount: topRated.result.length,
        crossAxisCount: 2,
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                navigateTo(context, TopRatedPreviewScreen(topRated, index));
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
                            '$imageKey${topRated.result[index].posterImage}'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        '${topRated.result[index].title}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AutoSizeText(
                        '${topRated.result[index].releaseDate}',
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
                            '${topRated.result[index].voteAverage}',
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
                                        name: topRated.result[index].title,
                                        releaseDate:
                                            topRated.result[index].releaseDate,
                                        voteRate:
                                            topRated.result[index].voteAverage,
                                        overView:
                                            topRated.result[index].overView);
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
                                        title: topRated.result[index].title);
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
