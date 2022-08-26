enum UpvoteStatus {
  UPVOTE,
  UNUPVOTE,
  DOWNVOTE,
  UNDOWNVOTE,
}

extension ResponseStatusExtension on UpvoteStatus {
  static const statusCodes = {
    UpvoteStatus.UPVOTE: "upvote",
    UpvoteStatus.UNUPVOTE: "unupvote",
    UpvoteStatus.DOWNVOTE: "downvote",
    UpvoteStatus.UNDOWNVOTE: "undownvote",
  };

  String? get statusCode => statusCodes[this];
}
