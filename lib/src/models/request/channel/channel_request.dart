import '../../Item.dart';

class ChannelRequest {
  ChannelRequest({
    this.pageSize,
    this.pageNum,
    this.offset,
    this.name,
  });

  int pageSize = 10;
  int pageNum = 1;
  int offset;
  String name;

  Map<String, dynamic> toMap() {
    return {'pageSize': pageSize, 'pageNum': pageNum, 'offset': offset, 'name': name};
  }
}
