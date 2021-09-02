import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:movies_app/bloc/main_bloc.dart';
import 'package:movies_app/bloc/main_state.dart';
import 'package:movies_app/constances/theme.dart';
import 'package:movies_app/models/wish_list_model.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText('wish list'),
      ),
      body: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var wishList = MainCubit
              .get(context)
              .wishList;
          return Conditional.single(context: context,
              conditionBuilder: (context) => wishList.length !=0,
              widgetBuilder: (context) => buildWishListItem(context, wishList),
              fallbackBuilder: (context) =>
                  Center(child: CircularProgressIndicator(
                    color: MyColor.mainColor,))
          );
        },
      ),
    );
  }
}

buildWishListItem(context, List<WishListModel> wishList) =>
    ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) =>
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.0,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: Text(
                        '${wishList[index].id}',
                        style: TextStyle(
                            color: MyColor.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: MyColor.mainColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            '${wishList[index].name}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,
                          ),
                          Row(
                            children: [
                              AutoSizeText(
                                '${wishList[index].releaseDate}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                              ),
                              Spacer(),
                              AutoSizeText(
                                '${wishList[index].voteRate}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText1,
                              ),
                              Icon(
                                Icons.star_rate_rounded,
                                color: MyColor.mainColor,
                              )
                            ],
                          ),
                          Divider(),
                          AutoSizeText(
                              '${wishList[index].overView}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(
            height: 5.0,
          ),
      itemCount: wishList.length,
    );
