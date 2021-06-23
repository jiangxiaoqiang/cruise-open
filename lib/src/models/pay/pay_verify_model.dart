class PayVerifyModel {
  PayVerifyModel({this.orderId, this.receipt, required this.isSandBox});

  String? orderId;
  String? receipt;
  bool isSandBox;

  Map<String, dynamic> toMap() {
    return {
      //'pageSize': pageSize,
      //'pageNum': pageNum,
      //'offset': offset,
      //'channelId': channelId
    };
  }
}
