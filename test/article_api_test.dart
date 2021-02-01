import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test("测试网络请求", () async {
    // 假如这个请求需要一个 token
    final token = "54321";
    final response = await http.get(
      "https://api.myjson.com/bins/18mjgh",
      headers: {"token": token},
    );
    if (response.statusCode == 200) {
      // 验证请求 header 中的 token
      expect(response.request.headers['token'], token);
      print(response.request.headers['token']);
      print(response.body);
      // 解析返回的 json
      //Person person = parsePersonJson(response.body);
      // 验证 person 对象不为空
      //expect(person, isNotNull);
      // 检测 person 对象中的属性值是否都正确
      //expect(person.name, "Lili");
      //expect(person.age, 20);
      //expect(person.country, 'China');
    }
  });
}
