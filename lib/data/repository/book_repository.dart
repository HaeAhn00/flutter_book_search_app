import 'dart:convert';

import 'package:flutter_book_search_app/data/model/book.dart';
import 'package:http/http.dart';

class BookRepository {
  Future<List<Book>> searchBooks(String query) async {
    final client = Client();
    try {
      final response = await client.get(
        // Uri.https를 사용하면 쿼리 파라미터를 더 안전하게 인코딩할 수 있습니다.
        Uri.https(
            'openapi.naver.com', '/v1/search/book.json', {'query': query}),
        headers: {
          'X-Naver-Client-Id': 'SquIdB4sQ6fg3NEhBXMh',
          'X-Naver-Client-Secret': 'hGggQGAhDE',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // API 응답에서 'items' 키가 없을 경우를 대비하여 기본값 []을 사용합니다.
        final List<dynamic> items = jsonResponse['items'] ?? [];
        // 여러 줄의 map, toList 코드를 한 줄로 간결하게 표현할 수 있습니다.
        return items.map((item) => Book.fromJson(item)).toList();
      } else {
        // 요청이 실패했을 때 예외를 발생시켜 호출한 쪽에서 에러 상황을 인지하고 처리하도록 합니다.
        throw Exception(
            'Failed to load books. Status code: ${response.statusCode}');
      }
    } finally {
      // 요청 성공/실패 여부와 관계없이 http.Client 리소스를 항상 해제합니다.
      client.close();
    }
  }
}
