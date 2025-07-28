import 'dart:convert';

import 'package:flutter_book_search_app/data/model/book.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Book model test', () {
    String dummyData = """
    {
      "title": "Harry! (Gedichte)",
      "link": "https://search.shopping.naver.com/book/catalog/32524001879",
      "image": "https://shopping-phinf.pstatic.net/main_3252400/32524001879.20250612073005.jpg",
      "author": "",
      "discount": "22410",
      "publisher": "Books on Demand",
      "pubdate": "20210519",
      "isbn": "9783753499949",
      "description": "Liebe zieht sich wie ein roter Faden \\ndurch unser Leben: \\nLebens- und Liebesgedichte"
    }
""";
    Map<String, dynamic> map = jsonDecode(dummyData);

    Book book = Book.fromJson(map);
    expect(book.discount, '22410');
    print(book.toJson());
  });
}
