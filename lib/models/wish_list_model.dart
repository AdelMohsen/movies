class WishListModel {
  dynamic id;
  String? index;
  String? name;
  String? releaseDate;
  dynamic voteRate;
  String? overView;

  WishListModel({
    this.id,
    required this.index,
    required this.name,
    required this.releaseDate,
    required this.voteRate,
    required this.overView,
  });

  WishListModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    index = map['idx'];
    name = map['name'];
    releaseDate = map['releaseDate'];
    voteRate = map['voteRate'];
    overView = map['overView'];
  }
}
