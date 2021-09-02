import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_app/bloc/main_bloc.dart';
import 'package:movies_app/bloc/main_state.dart';
import 'package:movies_app/constances/const_string.dart';
import 'package:movies_app/constances/reuse_widgets.dart';
import 'package:movies_app/models/populer_models.dart';
import 'package:movies_app/views/previews_screen/preview_page.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        var popularModel = MainCubit.get(context).popularModel;
        return buildPopularItem(context, cubit, popularModel);
      },
    );
  }
}

buildPopularItem(context, MainCubit cubit, PopularModel? popularModel) =>
    StaggeredGridView.countBuilder(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        mainAxisSpacing: 8,
        crossAxisSpacing: 2,
        itemCount: popularModel!.result!.length,
        crossAxisCount: 2,
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                navigateTo(context, PopularPreviewScreen(popularModel, index));
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
                            '$imageKey${popularModel.result![index].posterImage}'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        '${popularModel.result![index].title}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AutoSizeText(
                        '${popularModel.result![index].releaseDate}',
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
                            '${popularModel.result![index].voteAverage}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Icon(Icons.star_rate_rounded),
                          Spacer(),
                          cubit.changeFaVIcon
                              ? IconButton(
                                  onPressed: () {
                                     cubit.insertInWishListTable(index: index.toString(),
                                      name: popularModel.result![index].title,
                                        releaseDate: popularModel
                                            .result![index].releaseDate,
                                        voteRate: popularModel
                                            .result![index].voteAverage,
                                        overView: popularModel
                                            .result![index].overView);
                                  },
                                  icon: Icon(
                                    Icons.favorite_border_sharp,
                                    size: 30,
                                    color: HexColor('#ac1457'),
                                  ))
                              : IconButton(
                                  onPressed: () {
                                  cubit.deleteFromWishListTable(
                                        title:
                                            popularModel.result![index].title);
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: HexColor('#ac1457'),
                                  ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        staggeredTileBuilder: (index) => StaggeredTile.fit(1));
