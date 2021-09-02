import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:movies_app/bloc/main_bloc.dart';
import 'package:movies_app/bloc/main_state.dart';
import 'package:movies_app/constances/const_string.dart';
import 'package:movies_app/constances/theme.dart';
import 'package:movies_app/models/populer_models.dart';
import 'package:movies_app/constances/reuse_widgets.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class PopularPreviewScreen extends StatelessWidget {
  final PopularModel popularModel;
  final int index;
  PopularPreviewScreen(this.popularModel, this.index);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..getPopularVideos(
            videosId: popularModel.result![index].id),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var videoModel = MainCubit.get(context).videosModel;
          var cubit = MainCubit.get(context);
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
            popularModel.result!.length != 0,
            widgetBuilder: (context) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: AutoSizeText(
                  '${popularModel.result![index].title}',
                  minFontSize: 17,
                  maxFontSize: 25,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Card(
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColor.white)),
                          margin: EdgeInsets.zero,
                          elevation: 5.0,
                          child: Container(
                            width: double.infinity,
                            height: 280.0,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 5.0,
                                        child: FadeInImage.assetNetwork(
                                            height: 250.0,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            placeholder:
                                            'assets/images/loading.gif',
                                            image:
                                            '$imageUrl${popularModel.result![index].inSideImage}'),
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                          '${popularModel.result![index].title}',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        AutoSizeText(
                                          '${popularModel.result![index].releaseDate}',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star_rate_rounded,
                                              color: MyColor.mainColor,
                                            ),
                                            AutoSizeText(
                                              '${popularModel.result![index].voteAverage}',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: AutoSizeText(
                          'Overview',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                              fontSize: 25.0,
                              color: MyColor.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Card(
                        elevation: 5.0,
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColor.white)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: AutoSizeText(
                                '${popularModel.result![index].overView}',
                                minFontSize: 17,
                                maxFontSize: 22,
                                style: cubit.isReadMore
                                    ? Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.w500)
                                    : Theme.of(context).textTheme.headline6,
                                maxLines: cubit.isReadMore ? 3 : 15,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 8.0, right: 8.0),
                              child: Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              child: InkWell(
                                onTap: () {
                                  cubit.readMore();
                                },
                                child: AutoSizeText(
                                  cubit.isReadMore ? 'Read more' : 'Read less',
                                  style: TextStyle(
                                      color: MyColor.mainColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: AutoSizeText(
                          'Trailers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                              fontSize: 25.0,
                              color: MyColor.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                        state is! GetPopularVideosLoadingState,
                        widgetBuilder: (context) => Container(
                          height: 200,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  ytPlayer(context,'${videoModel!.result![index].key}'),
                              separatorBuilder: (context, index) => SizedBox(
                                width: 5,
                              ),
                              itemCount: videoModel!.result!.length),
                        ),
                        fallbackBuilder: (context) => Center(
                            child: CircularProgressIndicator(
                              color: MyColor.mainColor,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: MyColor.mainColor,
                onPressed: () {},
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            fallbackBuilder: (context) => Scaffold(
              appBar: AppBar(
                title: Text('loading'),
              ),
              body: Center(
                  child: CircularProgressIndicator(
                    color: MyColor.mainColor,
                  )),
            ),
          );
        },
      ),
    );
  }
}

Widget ytPlayer(context,videoID) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        _showDialog(
          context,
          videoID,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width-50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: new Image.network(
                YoutubePlayerController.getThumbnail(
                    videoId: '$videoID',
                    // todo: get thumbnail quality from list
                    quality: ThumbnailQuality.standard,
                    webp: false),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Icon(
            Icons.play_circle_filled,
            color: Colors.white,
            size: 55.0,
          ),
        ],
      ),
    ),
  );
}

void _showDialog(context, videoID) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return YoutubeViewer(
        '$videoID',
      );
    },
  );
}

