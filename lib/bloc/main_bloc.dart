import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/main_state.dart';
import 'package:movies_app/constances/const_string.dart';
import 'package:movies_app/models/videos_model.dart';
import 'package:movies_app/models/wish_list_model.dart';
import 'package:movies_app/network/dio_helper.dart';
import 'package:movies_app/models/UpComing.dart';
import 'package:movies_app/models/populer_models.dart';
import 'package:movies_app/models/top_rated.dart';
import 'package:sqflite/sqflite.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);
  Database? database;
  PopularModel? popularModel;
  List<WishListModel> wishList = [];

  bool isReadMore = true;
  bool changeFaVIcon = true;

  bool mode =true;

  changeThemeMode(){
    mode = !mode;
    emit(ChangeThemeModeState());
  }

  changeIcon() {
    changeFaVIcon = !changeFaVIcon;
    emit(ChangeFavIconSuccess());
  }

  readMore() {
    isReadMore = !isReadMore;
    emit(ChangeReadMore());
  }

  getPopularData() {
    emit(GetPopularDataLoading());
    DioHelper.getData(url: popularUri).then((value) {
      popularModel = PopularModel.fromJson(value.data!);
      emit(GetPopularDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetPopularDataError());
    });
  }

  TopRated? topRated;

  getTopRatedData() {
    emit(GetTopRatedDataLoading());
    DioHelper.getData(url: topRatedUri).then((value) {
      topRated = TopRated.fromJson(value.data);
      emit(GetTopRatedDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetTopRatedDataError());
    });
  }

  UpComing? upComing;

  getUpComingData() {
    emit(GetUpComingDataLoading());
    DioHelper.getData(url: upComingUri).then((value) {
      upComing = UpComing.fromJson(value.data);
      emit(GetUpComingDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetUpComingDataError());
    });
  }

  VideosModel? videosModel;

  getPopularVideos({required videosId}) {
    emit(GetPopularVideosLoadingState());
    DioHelper.getVideos(videosId: videosId).then((value) {
      videosModel = VideosModel.fromJson(value.data);
       emit(GetPopularVideosSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPopularVideosErrorState());
    });
  }

//****************************************************************************
//SQFLITE
  void createDataBase() async {
    emit(OnCreateDatabaseLoading());
    database = await openDatabase(
      'movies.db',
      version: 1,
      onCreate: (database, version) =>
          onCreate(database, version).then((value) {
        print('tables created');
        emit(OnCreateDatabaseSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(OnCreateDatabaseError());
      }),
      onOpen: (database) async {
        emit(OnOpenDatabaseLoading());
        await getWishListData(database);
        print('on opened database');
      },
    );
  }

  Future<void> onCreate(Database database, int version) async {
    await database.execute(
        'CREATE TABLE wishList (id INTEGER PRIMARY KEY,name TEXT,releaseDate TEXT,voteRate TEXT,overView TEXT,idx TEXT)');
  }

  insertInWishListTable({
    required String? index,
    required String? name,
    required String? releaseDate,
    required dynamic voteRate,
    required String? overView,
  }) {
    database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO wishList (name,releaseDate,voteRate,overView,idx) VALUES ("$name","$releaseDate","$voteRate","$overView","$index")')
          .then((value) {
        getWishListData(database!);
        emit(InsertInWishListSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(InsertInWishListError());
      });
    });
  }

  getWishListData(Database database) {
    emit(GetWishListDataLoading());
    return database.rawQuery('SELECT * FROM wishList').then((value) {
      wishList = value.map((e) => WishListModel.fromMap(e)).toList();
      emit(GetWishListDataSuccess());
    }).catchError((error) {
      print(error);
      emit(GetWishListDataError());
    });
  }

  deleteFromWishListTable({
    required String? title,
  }) async {
    database!.rawDelete('DELETE FROM wishList WHERE name = ?', [title]).then(
        (value) {
      getWishListData(database!);
      emit(DeleteFromWishListSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteFromWishListError());
    });
  }
}
