class RestLogModel {
  RestLogModel({this.message});

  String? message;


  Map<String, dynamic> toMap() {
    return {
      "message": message
    };
  }
}
