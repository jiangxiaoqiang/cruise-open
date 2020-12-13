
enum UpvoteStatus {
  UPVOTE,
  UNUPVOTE,
}

extension ResponseStatusExtension on UpvoteStatus{
  static const statusCodes = {
    UpvoteStatus.UPVOTE: "upvote",
    UpvoteStatus.UNUPVOTE: "unupvote",
  };

  String get statusCode => statusCodes[this];
}