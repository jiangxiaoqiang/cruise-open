import 'package:html/parser.dart' show parse;

class HtmlUtils{

  static String htmlPipleline(String html) {
     var document = parse(html);
     print(document.outerHtml);
     return html;
  }
}


