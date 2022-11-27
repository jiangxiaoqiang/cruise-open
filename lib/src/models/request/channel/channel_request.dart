import 'dart:convert';

class ChannelRequest {
  ChannelRequest({required this.pageSize, required this.pageNum, this.offset, required this.name});

  int pageSize = 10;
  int pageNum = 1;
  int? offset;
  String? name;

  Map<String, dynamic> toMap() {
    return {'pageSize': pageSize, 'pageNum': pageNum, 'offset': offset, 'name': name};
  }

  String toJson() => json.encode(toMap());
}
