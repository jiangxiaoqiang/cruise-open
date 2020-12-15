
enum FavStatus {
  FAV,
  UNFAV,
}

extension ResponseStatusExtension on FavStatus{
  static const statusCodes = {
    FavStatus.FAV: "fav",
    FavStatus.UNFAV: "unfav",
  };

  String get statusCode => statusCodes[this];
}